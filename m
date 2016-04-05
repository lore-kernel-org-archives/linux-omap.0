From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v6 03/12] usb: otg-fsm: use usb_otg wherever possible
Date: Tue, 5 Apr 2016 17:05:08 +0300
Message-ID: <1459865117-7032-4-git-send-email-rogerq@ti.com>
References: <1459865117-7032-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459865117-7032-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: stern@rowland.harvard.edu, balbi@kernel.org, gregkh@linuxfoundation.org, peter.chen@freescale.com
Cc: dan.j.williams@intel.com, jun.li@freescale.com, mathias.nyman@linux.intel.com, tony@atomide.com, Joao.Pinto@synopsys.com, abrestic@chromium.org, r.baldyga@samsung.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Move otg_fsm into usb_otg and use usb_otg wherever possible
in the usb_otg APIs.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/usb/chipidea/ci.h        |   1 -
 drivers/usb/chipidea/core.c      |  12 +--
 drivers/usb/chipidea/debug.c     |   2 +-
 drivers/usb/chipidea/otg_fsm.c   | 171 ++++++++++++++++++-------------------
 drivers/usb/chipidea/udc.c       |  17 ++--
 drivers/usb/common/usb-otg-fsm.c | 180 ++++++++++++++++++++-------------------
 drivers/usb/phy/phy-fsl-usb.c    | 143 +++++++++++++++----------------
 drivers/usb/phy/phy-fsl-usb.h    |   3 +-
 include/linux/usb/otg-fsm.h      | 132 +++-------------------------
 include/linux/usb/otg.h          | 107 +++++++++++++++++++++++
 10 files changed, 384 insertions(+), 384 deletions(-)

diff --git a/drivers/usb/chipidea/ci.h b/drivers/usb/chipidea/ci.h
index cd41455..c523975 100644
--- a/drivers/usb/chipidea/ci.h
+++ b/drivers/usb/chipidea/ci.h
@@ -209,7 +209,6 @@ struct ci_hdrc {
 	enum ci_role			role;
 	bool				is_otg;
 	struct usb_otg			otg;
-	struct otg_fsm			fsm;
 	struct hrtimer			otg_fsm_hrtimer;
 	ktime_t				hr_timeouts[NUM_OTG_FSM_TIMERS];
 	unsigned			enabled_otg_timer_bits;
diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index 69426e6..a5570a9 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -1085,7 +1085,7 @@ static int ci_hdrc_remove(struct platform_device *pdev)
 /* Prepare wakeup by SRP before suspend */
 static void ci_otg_fsm_suspend_for_srp(struct ci_hdrc *ci)
 {
-	if ((ci->fsm.otg->state == OTG_STATE_A_IDLE) &&
+	if ((ci->otg.state == OTG_STATE_A_IDLE) &&
 				!hw_read_otgsc(ci, OTGSC_ID)) {
 		hw_write(ci, OP_PORTSC, PORTSC_W1C_BITS | PORTSC_PP,
 								PORTSC_PP);
@@ -1097,13 +1097,13 @@ static void ci_otg_fsm_suspend_for_srp(struct ci_hdrc *ci)
 /* Handle SRP when wakeup by data pulse */
 static void ci_otg_fsm_wakeup_by_srp(struct ci_hdrc *ci)
 {
-	if ((ci->fsm.otg->state == OTG_STATE_A_IDLE) &&
-		(ci->fsm.a_bus_drop == 1) && (ci->fsm.a_bus_req == 0)) {
+	if ((ci->otg.state == OTG_STATE_A_IDLE) &&
+		(ci->otg.fsm.a_bus_drop == 1) && (ci->otg.fsm.a_bus_req == 0)) {
 		if (!hw_read_otgsc(ci, OTGSC_ID)) {
-			ci->fsm.a_srp_det = 1;
-			ci->fsm.a_bus_drop = 0;
+			ci->otg.fsm.a_srp_det = 1;
+			ci->otg.fsm.a_bus_drop = 0;
 		} else {
-			ci->fsm.id = 1;
+			ci->otg.fsm.id = 1;
 		}
 		ci_otg_queue_work(ci);
 	}
diff --git a/drivers/usb/chipidea/debug.c b/drivers/usb/chipidea/debug.c
index 6d23eed..374cdaa 100644
--- a/drivers/usb/chipidea/debug.c
+++ b/drivers/usb/chipidea/debug.c
@@ -224,7 +224,7 @@ static int ci_otg_show(struct seq_file *s, void *unused)
 	if (!ci || !ci_otg_is_fsm_mode(ci))
 		return 0;
 
-	fsm = &ci->fsm;
+	fsm = &ci->otg.fsm;
 
 	/* ------ State ----- */
 	seq_printf(s, "OTG state: %s\n\n",
diff --git a/drivers/usb/chipidea/otg_fsm.c b/drivers/usb/chipidea/otg_fsm.c
index 5f169b3..f4e9fb5 100644
--- a/drivers/usb/chipidea/otg_fsm.c
+++ b/drivers/usb/chipidea/otg_fsm.c
@@ -40,7 +40,7 @@ get_a_bus_req(struct device *dev, struct device_attribute *attr, char *buf)
 
 	next = buf;
 	size = PAGE_SIZE;
-	t = scnprintf(next, size, "%d\n", ci->fsm.a_bus_req);
+	t = scnprintf(next, size, "%d\n", ci->otg.fsm.a_bus_req);
 	size -= t;
 	next += t;
 
@@ -56,25 +56,25 @@ set_a_bus_req(struct device *dev, struct device_attribute *attr,
 	if (count > 2)
 		return -1;
 
-	mutex_lock(&ci->fsm.lock);
+	mutex_lock(&ci->otg.fsm.lock);
 	if (buf[0] == '0') {
-		ci->fsm.a_bus_req = 0;
+		ci->otg.fsm.a_bus_req = 0;
 	} else if (buf[0] == '1') {
 		/* If a_bus_drop is TRUE, a_bus_req can't be set */
-		if (ci->fsm.a_bus_drop) {
-			mutex_unlock(&ci->fsm.lock);
+		if (ci->otg.fsm.a_bus_drop) {
+			mutex_unlock(&ci->otg.fsm.lock);
 			return count;
 		}
-		ci->fsm.a_bus_req = 1;
-		if (ci->fsm.otg->state == OTG_STATE_A_PERIPHERAL) {
+		ci->otg.fsm.a_bus_req = 1;
+		if (ci->otg.state == OTG_STATE_A_PERIPHERAL) {
 			ci->gadget.host_request_flag = 1;
-			mutex_unlock(&ci->fsm.lock);
+			mutex_unlock(&ci->otg.fsm.lock);
 			return count;
 		}
 	}
 
 	ci_otg_queue_work(ci);
-	mutex_unlock(&ci->fsm.lock);
+	mutex_unlock(&ci->otg.fsm.lock);
 
 	return count;
 }
@@ -89,7 +89,7 @@ get_a_bus_drop(struct device *dev, struct device_attribute *attr, char *buf)
 
 	next = buf;
 	size = PAGE_SIZE;
-	t = scnprintf(next, size, "%d\n", ci->fsm.a_bus_drop);
+	t = scnprintf(next, size, "%d\n", ci->otg.fsm.a_bus_drop);
 	size -= t;
 	next += t;
 
@@ -105,16 +105,16 @@ set_a_bus_drop(struct device *dev, struct device_attribute *attr,
 	if (count > 2)
 		return -1;
 
-	mutex_lock(&ci->fsm.lock);
+	mutex_lock(&ci->otg.fsm.lock);
 	if (buf[0] == '0') {
-		ci->fsm.a_bus_drop = 0;
+		ci->otg.fsm.a_bus_drop = 0;
 	} else if (buf[0] == '1') {
-		ci->fsm.a_bus_drop = 1;
-		ci->fsm.a_bus_req = 0;
+		ci->otg.fsm.a_bus_drop = 1;
+		ci->otg.fsm.a_bus_req = 0;
 	}
 
 	ci_otg_queue_work(ci);
-	mutex_unlock(&ci->fsm.lock);
+	mutex_unlock(&ci->otg.fsm.lock);
 
 	return count;
 }
@@ -130,7 +130,7 @@ get_b_bus_req(struct device *dev, struct device_attribute *attr, char *buf)
 
 	next = buf;
 	size = PAGE_SIZE;
-	t = scnprintf(next, size, "%d\n", ci->fsm.b_bus_req);
+	t = scnprintf(next, size, "%d\n", ci->otg.fsm.b_bus_req);
 	size -= t;
 	next += t;
 
@@ -146,20 +146,20 @@ set_b_bus_req(struct device *dev, struct device_attribute *attr,
 	if (count > 2)
 		return -1;
 
-	mutex_lock(&ci->fsm.lock);
+	mutex_lock(&ci->otg.fsm.lock);
 	if (buf[0] == '0')
-		ci->fsm.b_bus_req = 0;
+		ci->otg.fsm.b_bus_req = 0;
 	else if (buf[0] == '1') {
-		ci->fsm.b_bus_req = 1;
-		if (ci->fsm.otg->state == OTG_STATE_B_PERIPHERAL) {
+		ci->otg.fsm.b_bus_req = 1;
+		if (ci->otg.state == OTG_STATE_B_PERIPHERAL) {
 			ci->gadget.host_request_flag = 1;
-			mutex_unlock(&ci->fsm.lock);
+			mutex_unlock(&ci->otg.fsm.lock);
 			return count;
 		}
 	}
 
 	ci_otg_queue_work(ci);
-	mutex_unlock(&ci->fsm.lock);
+	mutex_unlock(&ci->otg.fsm.lock);
 
 	return count;
 }
@@ -174,12 +174,12 @@ set_a_clr_err(struct device *dev, struct device_attribute *attr,
 	if (count > 2)
 		return -1;
 
-	mutex_lock(&ci->fsm.lock);
+	mutex_lock(&ci->otg.fsm.lock);
 	if (buf[0] == '1')
-		ci->fsm.a_clr_err = 1;
+		ci->otg.fsm.a_clr_err = 1;
 
 	ci_otg_queue_work(ci);
-	mutex_unlock(&ci->fsm.lock);
+	mutex_unlock(&ci->otg.fsm.lock);
 
 	return count;
 }
@@ -287,64 +287,64 @@ static void ci_otg_del_timer(struct ci_hdrc *ci, enum otg_fsm_timer t)
 /* OTG FSM timer handlers */
 static int a_wait_vrise_tmout(struct ci_hdrc *ci)
 {
-	ci->fsm.a_wait_vrise_tmout = 1;
+	ci->otg.fsm.a_wait_vrise_tmout = 1;
 	return 0;
 }
 
 static int a_wait_vfall_tmout(struct ci_hdrc *ci)
 {
-	ci->fsm.a_wait_vfall_tmout = 1;
+	ci->otg.fsm.a_wait_vfall_tmout = 1;
 	return 0;
 }
 
 static int a_wait_bcon_tmout(struct ci_hdrc *ci)
 {
-	ci->fsm.a_wait_bcon_tmout = 1;
+	ci->otg.fsm.a_wait_bcon_tmout = 1;
 	return 0;
 }
 
 static int a_aidl_bdis_tmout(struct ci_hdrc *ci)
 {
-	ci->fsm.a_aidl_bdis_tmout = 1;
+	ci->otg.fsm.a_aidl_bdis_tmout = 1;
 	return 0;
 }
 
 static int b_ase0_brst_tmout(struct ci_hdrc *ci)
 {
-	ci->fsm.b_ase0_brst_tmout = 1;
+	ci->otg.fsm.b_ase0_brst_tmout = 1;
 	return 0;
 }
 
 static int a_bidl_adis_tmout(struct ci_hdrc *ci)
 {
-	ci->fsm.a_bidl_adis_tmout = 1;
+	ci->otg.fsm.a_bidl_adis_tmout = 1;
 	return 0;
 }
 
 static int b_aidl_bdis_tmout(struct ci_hdrc *ci)
 {
-	ci->fsm.a_bus_suspend = 1;
+	ci->otg.fsm.a_bus_suspend = 1;
 	return 0;
 }
 
 static int b_se0_srp_tmout(struct ci_hdrc *ci)
 {
-	ci->fsm.b_se0_srp = 1;
+	ci->otg.fsm.b_se0_srp = 1;
 	return 0;
 }
 
 static int b_srp_fail_tmout(struct ci_hdrc *ci)
 {
-	ci->fsm.b_srp_done = 1;
+	ci->otg.fsm.b_srp_done = 1;
 	return 1;
 }
 
 static int b_data_pls_tmout(struct ci_hdrc *ci)
 {
-	ci->fsm.b_srp_done = 1;
-	ci->fsm.b_bus_req = 0;
-	if (ci->fsm.power_up)
-		ci->fsm.power_up = 0;
+	ci->otg.fsm.b_srp_done = 1;
+	ci->otg.fsm.b_bus_req = 0;
+	if (ci->otg.fsm.power_up)
+		ci->otg.fsm.power_up = 0;
 	hw_write_otgsc(ci, OTGSC_HABA, 0);
 	pm_runtime_put(ci->dev);
 	return 0;
@@ -352,9 +352,9 @@ static int b_data_pls_tmout(struct ci_hdrc *ci)
 
 static int b_ssend_srp_tmout(struct ci_hdrc *ci)
 {
-	ci->fsm.b_ssend_srp = 1;
+	ci->otg.fsm.b_ssend_srp = 1;
 	/* only vbus fall below B_sess_vld in b_idle state */
-	if (ci->fsm.otg->state == OTG_STATE_B_IDLE)
+	if (ci->otg.state == OTG_STATE_B_IDLE)
 		return 0;
 	else
 		return 1;
@@ -435,18 +435,18 @@ static int ci_otg_init_timers(struct ci_hdrc *ci)
 /* -------------------------------------------------------------*/
 /* Operations that will be called from OTG Finite State Machine */
 /* -------------------------------------------------------------*/
-static void ci_otg_fsm_add_timer(struct otg_fsm *fsm, enum otg_fsm_timer t)
+static void ci_otg_fsm_add_timer(struct usb_otg *otg, enum otg_fsm_timer t)
 {
-	struct ci_hdrc	*ci = container_of(fsm, struct ci_hdrc, fsm);
+	struct ci_hdrc	*ci = container_of(otg, struct ci_hdrc, otg);
 
 	if (t < NUM_OTG_FSM_TIMERS)
 		ci_otg_add_timer(ci, t);
 	return;
 }
 
-static void ci_otg_fsm_del_timer(struct otg_fsm *fsm, enum otg_fsm_timer t)
+static void ci_otg_fsm_del_timer(struct usb_otg *otg, enum otg_fsm_timer t)
 {
-	struct ci_hdrc	*ci = container_of(fsm, struct ci_hdrc, fsm);
+	struct ci_hdrc	*ci = container_of(otg, struct ci_hdrc, otg);
 
 	if (t < NUM_OTG_FSM_TIMERS)
 		ci_otg_del_timer(ci, t);
@@ -457,10 +457,10 @@ static void ci_otg_fsm_del_timer(struct otg_fsm *fsm, enum otg_fsm_timer t)
  * A-device drive vbus: turn on vbus regulator and enable port power
  * Data pulse irq should be disabled while vbus is on.
  */
-static void ci_otg_drv_vbus(struct otg_fsm *fsm, int on)
+static void ci_otg_drv_vbus(struct usb_otg *otg, int on)
 {
 	int ret;
-	struct ci_hdrc	*ci = container_of(fsm, struct ci_hdrc, fsm);
+	struct ci_hdrc	*ci = container_of(otg, struct ci_hdrc, otg);
 
 	if (on) {
 		/* Enable power power */
@@ -478,23 +478,23 @@ static void ci_otg_drv_vbus(struct otg_fsm *fsm, int on)
 		/* Disable data pulse irq */
 		hw_write_otgsc(ci, OTGSC_DPIE, 0);
 
-		fsm->a_srp_det = 0;
-		fsm->power_up = 0;
+		otg->fsm.a_srp_det = 0;
+		otg->fsm.power_up = 0;
 	} else {
 		if (ci->platdata->reg_vbus)
 			regulator_disable(ci->platdata->reg_vbus);
 
-		fsm->a_bus_drop = 1;
-		fsm->a_bus_req = 0;
+		otg->fsm.a_bus_drop = 1;
+		otg->fsm.a_bus_req = 0;
 	}
 }
 
 /*
  * Control data line by Run Stop bit.
  */
-static void ci_otg_loc_conn(struct otg_fsm *fsm, int on)
+static void ci_otg_loc_conn(struct usb_otg *otg, int on)
 {
-	struct ci_hdrc	*ci = container_of(fsm, struct ci_hdrc, fsm);
+	struct ci_hdrc	*ci = container_of(otg, struct ci_hdrc, otg);
 
 	if (on)
 		hw_write(ci, OP_USBCMD, USBCMD_RS, USBCMD_RS);
@@ -511,14 +511,14 @@ static void ci_otg_loc_conn(struct otg_fsm *fsm, int on)
  * so the usb device class driver need support autosuspend,
  * otherwise the bus suspend will not happen.
  */
-static void ci_otg_loc_sof(struct otg_fsm *fsm, int on)
+static void ci_otg_loc_sof(struct usb_otg *otg, int on)
 {
 	struct usb_device *udev;
 
-	if (!fsm->otg->host)
+	if (!otg->host)
 		return;
 
-	udev = usb_hub_find_child(fsm->otg->host->root_hub, 1);
+	udev = usb_hub_find_child(otg->host->root_hub, 1);
 	if (!udev)
 		return;
 
@@ -534,9 +534,9 @@ static void ci_otg_loc_sof(struct otg_fsm *fsm, int on)
  * Start SRP pulsing by data-line pulsing,
  * no v-bus pulsing followed
  */
-static void ci_otg_start_pulse(struct otg_fsm *fsm)
+static void ci_otg_start_pulse(struct usb_otg *otg)
 {
-	struct ci_hdrc	*ci = container_of(fsm, struct ci_hdrc, fsm);
+	struct ci_hdrc	*ci = container_of(otg, struct ci_hdrc, otg);
 
 	/* Hardware Assistant Data pulse */
 	hw_write_otgsc(ci, OTGSC_HADP, OTGSC_HADP);
@@ -545,9 +545,9 @@ static void ci_otg_start_pulse(struct otg_fsm *fsm)
 	ci_otg_add_timer(ci, B_DATA_PLS);
 }
 
-static int ci_otg_start_host(struct otg_fsm *fsm, int on)
+static int ci_otg_start_host(struct usb_otg *otg, int on)
 {
-	struct ci_hdrc	*ci = container_of(fsm, struct ci_hdrc, fsm);
+	struct ci_hdrc	*ci = container_of(otg, struct ci_hdrc, otg);
 
 	if (on) {
 		ci_role_stop(ci);
@@ -559,9 +559,9 @@ static int ci_otg_start_host(struct otg_fsm *fsm, int on)
 	return 0;
 }
 
-static int ci_otg_start_gadget(struct otg_fsm *fsm, int on)
+static int ci_otg_start_gadget(struct usb_otg *otg, int on)
 {
-	struct ci_hdrc	*ci = container_of(fsm, struct ci_hdrc, fsm);
+	struct ci_hdrc	*ci = container_of(otg, struct ci_hdrc, otg);
 
 	if (on)
 		usb_gadget_vbus_connect(&ci->gadget);
@@ -588,13 +588,13 @@ int ci_otg_fsm_work(struct ci_hdrc *ci)
 	 * Don't do fsm transition for B device
 	 * when there is no gadget class driver
 	 */
-	if (ci->fsm.id && !(ci->driver) &&
-		ci->fsm.otg->state < OTG_STATE_A_IDLE)
+	if (ci->otg.fsm.id && !(ci->driver) &&
+		ci->otg.state < OTG_STATE_A_IDLE)
 		return 0;
 
 	pm_runtime_get_sync(ci->dev);
-	if (otg_statemachine(&ci->fsm)) {
-		if (ci->fsm.otg->state == OTG_STATE_A_IDLE) {
+	if (otg_statemachine(&ci->otg)) {
+		if (ci->otg.state == OTG_STATE_A_IDLE) {
 			/*
 			 * Further state change for cases:
 			 * a_idle to b_idle; or
@@ -603,8 +603,8 @@ int ci_otg_fsm_work(struct ci_hdrc *ci)
 			 * consequently; or
 			 * a_idle to a_wait_vrise when power up
 			 */
-			if ((ci->fsm.id) || (ci->id_event) ||
-						(ci->fsm.power_up)) {
+			if ((ci->otg.fsm.id) || (ci->id_event) ||
+						(ci->otg.fsm.power_up)) {
 				ci_otg_queue_work(ci);
 			} else {
 				/* Enable data pulse irq */
@@ -615,16 +615,16 @@ int ci_otg_fsm_work(struct ci_hdrc *ci)
 			}
 			if (ci->id_event)
 				ci->id_event = false;
-		} else if (ci->fsm.otg->state == OTG_STATE_B_IDLE) {
-			if (ci->fsm.b_sess_vld) {
-				ci->fsm.power_up = 0;
+		} else if (ci->otg.state == OTG_STATE_B_IDLE) {
+			if (ci->otg.fsm.b_sess_vld) {
+				ci->otg.fsm.power_up = 0;
 				/*
 				 * Further transite to b_periphearl state
 				 * when register gadget driver with vbus on
 				 */
 				ci_otg_queue_work(ci);
 			}
-		} else if (ci->fsm.otg->state == OTG_STATE_A_HOST) {
+		} else if (ci->otg.state == OTG_STATE_A_HOST) {
 			pm_runtime_mark_last_busy(ci->dev);
 			pm_runtime_put_autosuspend(ci->dev);
 			return 0;
@@ -641,13 +641,13 @@ int ci_otg_fsm_work(struct ci_hdrc *ci)
 static void ci_otg_fsm_event(struct ci_hdrc *ci)
 {
 	u32 intr_sts, otg_bsess_vld, port_conn;
-	struct otg_fsm *fsm = &ci->fsm;
+	struct otg_fsm *fsm = &ci->otg.fsm;
 
 	intr_sts = hw_read_intr_status(ci);
 	otg_bsess_vld = hw_read_otgsc(ci, OTGSC_BSV);
 	port_conn = hw_read(ci, OP_PORTSC, PORTSC_CCS);
 
-	switch (ci->fsm.otg->state) {
+	switch (ci->otg.state) {
 	case OTG_STATE_A_WAIT_BCON:
 		if (port_conn) {
 			fsm->b_conn = 1;
@@ -737,7 +737,7 @@ irqreturn_t ci_otg_fsm_irq(struct ci_hdrc *ci)
 {
 	irqreturn_t retval =  IRQ_NONE;
 	u32 otgsc, otg_int_src = 0;
-	struct otg_fsm *fsm = &ci->fsm;
+	struct otg_fsm *fsm = &ci->otg.fsm;
 
 	otgsc = hw_read_otgsc(ci, ~0);
 	otg_int_src = otgsc & OTGSC_INT_STATUS_BITS & (otgsc >> 8);
@@ -800,18 +800,17 @@ int ci_hdrc_otg_fsm_init(struct ci_hdrc *ci)
 		ci->otg.usb_phy = ci->usb_phy;
 
 	ci->otg.gadget = &ci->gadget;
-	ci->fsm.otg = &ci->otg;
-	ci->fsm.power_up = 1;
-	ci->fsm.id = hw_read_otgsc(ci, OTGSC_ID) ? 1 : 0;
-	ci->fsm.otg->state = OTG_STATE_UNDEFINED;
-	ci->fsm.ops = &ci_otg_ops;
-	ci->fsm.dev = ci->dev;
+	ci->otg.fsm.power_up = 1;
+	ci->otg.fsm.id = hw_read_otgsc(ci, OTGSC_ID) ? 1 : 0;
+	ci->otg.state = OTG_STATE_UNDEFINED;
+	ci->otg.fsm.ops = &ci_otg_ops;
+	ci->otg.fsm.dev = ci->dev;
 	ci->gadget.hnp_polling_support = 1;
-	ci->fsm.host_req_flag = devm_kzalloc(ci->dev, 1, GFP_KERNEL);
-	if (!ci->fsm.host_req_flag)
+	ci->otg.fsm.host_req_flag = devm_kzalloc(ci->dev, 1, GFP_KERNEL);
+	if (!ci->otg.fsm.host_req_flag)
 		return -ENOMEM;
 
-	mutex_init(&ci->fsm.lock);
+	mutex_init(&ci->otg.fsm.lock);
 
 	retval = ci_otg_init_timers(ci);
 	if (retval) {
@@ -831,10 +830,10 @@ int ci_hdrc_otg_fsm_init(struct ci_hdrc *ci)
 	/* Enable A vbus valid irq */
 	hw_write_otgsc(ci, OTGSC_AVVIE, OTGSC_AVVIE);
 
-	if (ci->fsm.id) {
-		ci->fsm.b_ssend_srp =
+	if (ci->otg.fsm.id) {
+		ci->otg.fsm.b_ssend_srp =
 			hw_read_otgsc(ci, OTGSC_BSV) ? 0 : 1;
-		ci->fsm.b_sess_vld =
+		ci->otg.fsm.b_sess_vld =
 			hw_read_otgsc(ci, OTGSC_BSV) ? 1 : 0;
 		/* Enable BSV irq */
 		hw_write_otgsc(ci, OTGSC_BSVIE, OTGSC_BSVIE);
diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
index 065f5d9..7a6b0b5 100644
--- a/drivers/usb/chipidea/udc.c
+++ b/drivers/usb/chipidea/udc.c
@@ -20,6 +20,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
+#include <linux/usb/otg.h>
 #include <linux/usb/otg-fsm.h>
 #include <linux/usb/chipidea.h>
 
@@ -1739,7 +1740,7 @@ static int ci_udc_start(struct usb_gadget *gadget,
 	ci->driver = driver;
 
 	/* Start otg fsm for B-device */
-	if (ci_otg_is_fsm_mode(ci) && ci->fsm.id) {
+	if (ci_otg_is_fsm_mode(ci) && ci->otg.fsm.id) {
 		ci_hdrc_otg_fsm_start(ci);
 		return retval;
 	}
@@ -1767,15 +1768,15 @@ static void ci_udc_stop_for_otg_fsm(struct ci_hdrc *ci)
 	if (!ci_otg_is_fsm_mode(ci))
 		return;
 
-	mutex_lock(&ci->fsm.lock);
-	if (ci->fsm.otg->state == OTG_STATE_A_PERIPHERAL) {
-		ci->fsm.a_bidl_adis_tmout = 1;
+	mutex_lock(&ci->otg.fsm.lock);
+	if (ci->otg.state == OTG_STATE_A_PERIPHERAL) {
+		ci->otg.fsm.a_bidl_adis_tmout = 1;
 		ci_hdrc_otg_fsm_start(ci);
-	} else if (ci->fsm.otg->state == OTG_STATE_B_PERIPHERAL) {
-		ci->fsm.protocol = PROTO_UNDEF;
-		ci->fsm.otg->state = OTG_STATE_UNDEFINED;
+	} else if (ci->otg.state == OTG_STATE_B_PERIPHERAL) {
+		ci->otg.fsm.protocol = PROTO_UNDEF;
+		ci->otg.state = OTG_STATE_UNDEFINED;
 	}
-	mutex_unlock(&ci->fsm.lock);
+	mutex_unlock(&ci->otg.fsm.lock);
 }
 
 /**
diff --git a/drivers/usb/common/usb-otg-fsm.c b/drivers/usb/common/usb-otg-fsm.c
index c5a61fe..abc462c 100644
--- a/drivers/usb/common/usb-otg-fsm.c
+++ b/drivers/usb/common/usb-otg-fsm.c
@@ -33,6 +33,7 @@
 /* Change USB protocol when there is a protocol change */
 static int otg_set_protocol(struct otg_fsm *fsm, int protocol)
 {
+	struct usb_otg *otg = container_of(fsm, struct usb_otg, fsm);
 	int ret = 0;
 
 	if (fsm->protocol != protocol) {
@@ -41,17 +42,17 @@ static int otg_set_protocol(struct otg_fsm *fsm, int protocol)
 			 fsm->protocol, protocol);
 		/* stop old protocol */
 		if (fsm->protocol == PROTO_HOST)
-			ret = otg_start_host(fsm, 0);
+			ret = otg_start_host(otg, 0);
 		else if (fsm->protocol == PROTO_GADGET)
-			ret = otg_start_gadget(fsm, 0);
+			ret = otg_start_gadget(otg, 0);
 		if (ret)
 			return ret;
 
 		/* start new protocol */
 		if (protocol == PROTO_HOST)
-			ret = otg_start_host(fsm, 1);
+			ret = otg_start_host(otg, 1);
 		else if (protocol == PROTO_GADGET)
-			ret = otg_start_gadget(fsm, 1);
+			ret = otg_start_gadget(otg, 1);
 		if (ret)
 			return ret;
 
@@ -65,9 +66,11 @@ static int otg_set_protocol(struct otg_fsm *fsm, int protocol)
 /* Called when leaving a state.  Do state clean up jobs here */
 static void otg_leave_state(struct otg_fsm *fsm, enum usb_otg_state old_state)
 {
+	struct usb_otg *otg = container_of(fsm, struct usb_otg, fsm);
+
 	switch (old_state) {
 	case OTG_STATE_B_IDLE:
-		otg_del_timer(fsm, B_SE0_SRP);
+		otg_del_timer(otg, B_SE0_SRP);
 		fsm->b_se0_srp = 0;
 		fsm->adp_sns = 0;
 		fsm->adp_prb = 0;
@@ -77,11 +80,11 @@ static void otg_leave_state(struct otg_fsm *fsm, enum usb_otg_state old_state)
 		fsm->b_srp_done = 0;
 		break;
 	case OTG_STATE_B_PERIPHERAL:
-		if (fsm->otg->gadget)
-			fsm->otg->gadget->host_request_flag = 0;
+		if (otg->gadget)
+			otg->gadget->host_request_flag = 0;
 		break;
 	case OTG_STATE_B_WAIT_ACON:
-		otg_del_timer(fsm, B_ASE0_BRST);
+		otg_del_timer(otg, B_ASE0_BRST);
 		fsm->b_ase0_brst_tmout = 0;
 		break;
 	case OTG_STATE_B_HOST:
@@ -90,31 +93,31 @@ static void otg_leave_state(struct otg_fsm *fsm, enum usb_otg_state old_state)
 		fsm->adp_prb = 0;
 		break;
 	case OTG_STATE_A_WAIT_VRISE:
-		otg_del_timer(fsm, A_WAIT_VRISE);
+		otg_del_timer(otg, A_WAIT_VRISE);
 		fsm->a_wait_vrise_tmout = 0;
 		break;
 	case OTG_STATE_A_WAIT_BCON:
-		otg_del_timer(fsm, A_WAIT_BCON);
+		otg_del_timer(otg, A_WAIT_BCON);
 		fsm->a_wait_bcon_tmout = 0;
 		break;
 	case OTG_STATE_A_HOST:
-		otg_del_timer(fsm, A_WAIT_ENUM);
+		otg_del_timer(otg, A_WAIT_ENUM);
 		break;
 	case OTG_STATE_A_SUSPEND:
-		otg_del_timer(fsm, A_AIDL_BDIS);
+		otg_del_timer(otg, A_AIDL_BDIS);
 		fsm->a_aidl_bdis_tmout = 0;
 		fsm->a_suspend_req_inf = 0;
 		break;
 	case OTG_STATE_A_PERIPHERAL:
-		otg_del_timer(fsm, A_BIDL_ADIS);
+		otg_del_timer(otg, A_BIDL_ADIS);
 		fsm->a_bidl_adis_tmout = 0;
-		if (fsm->otg->gadget)
-			fsm->otg->gadget->host_request_flag = 0;
+		if (otg->gadget)
+			otg->gadget->host_request_flag = 0;
 		break;
 	case OTG_STATE_A_WAIT_VFALL:
-		otg_del_timer(fsm, A_WAIT_VFALL);
+		otg_del_timer(otg, A_WAIT_VFALL);
 		fsm->a_wait_vfall_tmout = 0;
-		otg_del_timer(fsm, A_WAIT_VRISE);
+		otg_del_timer(otg, A_WAIT_VRISE);
 		break;
 	case OTG_STATE_A_VBUS_ERR:
 		break;
@@ -127,17 +130,18 @@ static void otg_hnp_polling_work(struct work_struct *work)
 {
 	struct otg_fsm *fsm = container_of(to_delayed_work(work),
 				struct otg_fsm, hnp_polling_work);
+	struct usb_otg *otg = container_of(fsm, struct usb_otg, fsm);
 	struct usb_device *udev;
-	enum usb_otg_state state = fsm->otg->state;
+	enum usb_otg_state state = otg->state;
 	u8 flag;
 	int retval;
 
 	if (state != OTG_STATE_A_HOST && state != OTG_STATE_B_HOST)
 		return;
 
-	udev = usb_hub_find_child(fsm->otg->host->root_hub, 1);
+	udev = usb_hub_find_child(otg->host->root_hub, 1);
 	if (!udev) {
-		dev_err(fsm->otg->host->controller,
+		dev_err(otg->host->controller,
 			"no usb dev connected, can't start HNP polling\n");
 		return;
 	}
@@ -172,7 +176,7 @@ static void otg_hnp_polling_work(struct work_struct *work)
 	/* Host request flag is set */
 	if (state == OTG_STATE_A_HOST) {
 		/* Set b_hnp_enable */
-		if (!fsm->otg->host->b_hnp_enable) {
+		if (!otg->host->b_hnp_enable) {
 			retval = usb_control_msg(udev,
 					usb_sndctrlpipe(udev, 0),
 					USB_REQ_SET_FEATURE, 0,
@@ -180,14 +184,14 @@ static void otg_hnp_polling_work(struct work_struct *work)
 					0, NULL, 0,
 					USB_CTRL_SET_TIMEOUT);
 			if (retval >= 0)
-				fsm->otg->host->b_hnp_enable = 1;
+				otg->host->b_hnp_enable = 1;
 		}
 		fsm->a_bus_req = 0;
 	} else if (state == OTG_STATE_B_HOST) {
 		fsm->b_bus_req = 0;
 	}
 
-	otg_statemachine(fsm);
+	otg_statemachine(otg);
 }
 
 static void otg_start_hnp_polling(struct otg_fsm *fsm)
@@ -207,133 +211,135 @@ static void otg_start_hnp_polling(struct otg_fsm *fsm)
 /* Called when entering a state */
 static int otg_set_state(struct otg_fsm *fsm, enum usb_otg_state new_state)
 {
-	if (fsm->otg->state == new_state)
+	struct usb_otg *otg = container_of(fsm, struct usb_otg, fsm);
+
+	if (otg->state == new_state)
 		return 0;
 	dev_vdbg(fsm->dev, "Set state: %s\n", usb_otg_state_string(new_state));
-	otg_leave_state(fsm, fsm->otg->state);
+	otg_leave_state(fsm, otg->state);
 	switch (new_state) {
 	case OTG_STATE_B_IDLE:
-		otg_drv_vbus(fsm, 0);
-		otg_chrg_vbus(fsm, 0);
-		otg_loc_conn(fsm, 0);
-		otg_loc_sof(fsm, 0);
+		otg_drv_vbus(otg, 0);
+		otg_chrg_vbus(otg, 0);
+		otg_loc_conn(otg, 0);
+		otg_loc_sof(otg, 0);
 		/*
 		 * Driver is responsible for starting ADP probing
 		 * if ADP sensing times out.
 		 */
-		otg_start_adp_sns(fsm);
+		otg_start_adp_sns(otg);
 		otg_set_protocol(fsm, PROTO_UNDEF);
-		otg_add_timer(fsm, B_SE0_SRP);
+		otg_add_timer(otg, B_SE0_SRP);
 		break;
 	case OTG_STATE_B_SRP_INIT:
-		otg_start_pulse(fsm);
-		otg_loc_sof(fsm, 0);
+		otg_start_pulse(otg);
+		otg_loc_sof(otg, 0);
 		otg_set_protocol(fsm, PROTO_UNDEF);
-		otg_add_timer(fsm, B_SRP_FAIL);
+		otg_add_timer(otg, B_SRP_FAIL);
 		break;
 	case OTG_STATE_B_PERIPHERAL:
-		otg_chrg_vbus(fsm, 0);
-		otg_loc_sof(fsm, 0);
+		otg_chrg_vbus(otg, 0);
+		otg_loc_sof(otg, 0);
 		otg_set_protocol(fsm, PROTO_GADGET);
-		otg_loc_conn(fsm, 1);
+		otg_loc_conn(otg, 1);
 		break;
 	case OTG_STATE_B_WAIT_ACON:
-		otg_chrg_vbus(fsm, 0);
-		otg_loc_conn(fsm, 0);
-		otg_loc_sof(fsm, 0);
+		otg_chrg_vbus(otg, 0);
+		otg_loc_conn(otg, 0);
+		otg_loc_sof(otg, 0);
 		otg_set_protocol(fsm, PROTO_HOST);
-		otg_add_timer(fsm, B_ASE0_BRST);
+		otg_add_timer(otg, B_ASE0_BRST);
 		fsm->a_bus_suspend = 0;
 		break;
 	case OTG_STATE_B_HOST:
-		otg_chrg_vbus(fsm, 0);
-		otg_loc_conn(fsm, 0);
-		otg_loc_sof(fsm, 1);
+		otg_chrg_vbus(otg, 0);
+		otg_loc_conn(otg, 0);
+		otg_loc_sof(otg, 1);
 		otg_set_protocol(fsm, PROTO_HOST);
-		usb_bus_start_enum(fsm->otg->host,
-				fsm->otg->host->otg_port);
+		usb_bus_start_enum(otg->host, otg->host->otg_port);
 		otg_start_hnp_polling(fsm);
 		break;
 	case OTG_STATE_A_IDLE:
-		otg_drv_vbus(fsm, 0);
-		otg_chrg_vbus(fsm, 0);
-		otg_loc_conn(fsm, 0);
-		otg_loc_sof(fsm, 0);
-		otg_start_adp_prb(fsm);
+		otg_drv_vbus(otg, 0);
+		otg_chrg_vbus(otg, 0);
+		otg_loc_conn(otg, 0);
+		otg_loc_sof(otg, 0);
+		otg_start_adp_prb(otg);
 		otg_set_protocol(fsm, PROTO_HOST);
 		break;
 	case OTG_STATE_A_WAIT_VRISE:
-		otg_drv_vbus(fsm, 1);
-		otg_loc_conn(fsm, 0);
-		otg_loc_sof(fsm, 0);
+		otg_drv_vbus(otg, 1);
+		otg_loc_conn(otg, 0);
+		otg_loc_sof(otg, 0);
 		otg_set_protocol(fsm, PROTO_HOST);
-		otg_add_timer(fsm, A_WAIT_VRISE);
+		otg_add_timer(otg, A_WAIT_VRISE);
 		break;
 	case OTG_STATE_A_WAIT_BCON:
-		otg_drv_vbus(fsm, 1);
-		otg_loc_conn(fsm, 0);
-		otg_loc_sof(fsm, 0);
+		otg_drv_vbus(otg, 1);
+		otg_loc_conn(otg, 0);
+		otg_loc_sof(otg, 0);
 		otg_set_protocol(fsm, PROTO_HOST);
-		otg_add_timer(fsm, A_WAIT_BCON);
+		otg_add_timer(otg, A_WAIT_BCON);
 		break;
 	case OTG_STATE_A_HOST:
-		otg_drv_vbus(fsm, 1);
-		otg_loc_conn(fsm, 0);
-		otg_loc_sof(fsm, 1);
+		otg_drv_vbus(otg, 1);
+		otg_loc_conn(otg, 0);
+		otg_loc_sof(otg, 1);
 		otg_set_protocol(fsm, PROTO_HOST);
 		/*
 		 * When HNP is triggered while a_bus_req = 0, a_host will
 		 * suspend too fast to complete a_set_b_hnp_en
 		 */
 		if (!fsm->a_bus_req || fsm->a_suspend_req_inf)
-			otg_add_timer(fsm, A_WAIT_ENUM);
+			otg_add_timer(otg, A_WAIT_ENUM);
 		otg_start_hnp_polling(fsm);
 		break;
 	case OTG_STATE_A_SUSPEND:
-		otg_drv_vbus(fsm, 1);
-		otg_loc_conn(fsm, 0);
-		otg_loc_sof(fsm, 0);
+		otg_drv_vbus(otg, 1);
+		otg_loc_conn(otg, 0);
+		otg_loc_sof(otg, 0);
 		otg_set_protocol(fsm, PROTO_HOST);
-		otg_add_timer(fsm, A_AIDL_BDIS);
+		otg_add_timer(otg, A_AIDL_BDIS);
 
 		break;
 	case OTG_STATE_A_PERIPHERAL:
-		otg_loc_sof(fsm, 0);
+		otg_loc_sof(otg, 0);
 		otg_set_protocol(fsm, PROTO_GADGET);
-		otg_drv_vbus(fsm, 1);
-		otg_loc_conn(fsm, 1);
-		otg_add_timer(fsm, A_BIDL_ADIS);
+		otg_drv_vbus(otg, 1);
+		otg_loc_conn(otg, 1);
+		otg_add_timer(otg, A_BIDL_ADIS);
 		break;
 	case OTG_STATE_A_WAIT_VFALL:
-		otg_drv_vbus(fsm, 0);
-		otg_loc_conn(fsm, 0);
-		otg_loc_sof(fsm, 0);
+		otg_drv_vbus(otg, 0);
+		otg_loc_conn(otg, 0);
+		otg_loc_sof(otg, 0);
 		otg_set_protocol(fsm, PROTO_HOST);
-		otg_add_timer(fsm, A_WAIT_VFALL);
+		otg_add_timer(otg, A_WAIT_VFALL);
 		break;
 	case OTG_STATE_A_VBUS_ERR:
-		otg_drv_vbus(fsm, 0);
-		otg_loc_conn(fsm, 0);
-		otg_loc_sof(fsm, 0);
+		otg_drv_vbus(otg, 0);
+		otg_loc_conn(otg, 0);
+		otg_loc_sof(otg, 0);
 		otg_set_protocol(fsm, PROTO_UNDEF);
 		break;
 	default:
 		break;
 	}
 
-	fsm->otg->state = new_state;
+	otg->state = new_state;
 	fsm->state_changed = 1;
 	return 0;
 }
 
 /* State change judgement */
-int otg_statemachine(struct otg_fsm *fsm)
+int otg_statemachine(struct usb_otg *otg)
 {
 	enum usb_otg_state state;
+	struct otg_fsm *fsm = &otg->fsm;
 
 	mutex_lock(&fsm->lock);
 
-	state = fsm->otg->state;
+	state = otg->state;
 	fsm->state_changed = 0;
 	/* State machine state change judgement */
 
@@ -348,7 +354,7 @@ int otg_statemachine(struct otg_fsm *fsm)
 	case OTG_STATE_B_IDLE:
 		if (!fsm->id)
 			otg_set_state(fsm, OTG_STATE_A_IDLE);
-		else if (fsm->b_sess_vld && fsm->otg->gadget)
+		else if (fsm->b_sess_vld && otg->gadget)
 			otg_set_state(fsm, OTG_STATE_B_PERIPHERAL);
 		else if ((fsm->b_bus_req || fsm->adp_change || fsm->power_up) &&
 				fsm->b_ssend_srp && fsm->b_se0_srp)
@@ -361,8 +367,8 @@ int otg_statemachine(struct otg_fsm *fsm)
 	case OTG_STATE_B_PERIPHERAL:
 		if (!fsm->id || !fsm->b_sess_vld)
 			otg_set_state(fsm, OTG_STATE_B_IDLE);
-		else if (fsm->b_bus_req && fsm->otg->
-				gadget->b_hnp_enable && fsm->a_bus_suspend)
+		else if (fsm->b_bus_req && otg->gadget->b_hnp_enable
+			 && fsm->a_bus_suspend)
 			otg_set_state(fsm, OTG_STATE_B_WAIT_ACON);
 		break;
 	case OTG_STATE_B_WAIT_ACON:
@@ -407,7 +413,7 @@ int otg_statemachine(struct otg_fsm *fsm)
 		if (fsm->id || fsm->a_bus_drop)
 			otg_set_state(fsm, OTG_STATE_A_WAIT_VFALL);
 		else if ((!fsm->a_bus_req || fsm->a_suspend_req_inf) &&
-				fsm->otg->host->b_hnp_enable)
+			 otg->host->b_hnp_enable)
 			otg_set_state(fsm, OTG_STATE_A_SUSPEND);
 		else if (!fsm->b_conn)
 			otg_set_state(fsm, OTG_STATE_A_WAIT_BCON);
@@ -415,9 +421,9 @@ int otg_statemachine(struct otg_fsm *fsm)
 			otg_set_state(fsm, OTG_STATE_A_VBUS_ERR);
 		break;
 	case OTG_STATE_A_SUSPEND:
-		if (!fsm->b_conn && fsm->otg->host->b_hnp_enable)
+		if (!fsm->b_conn && otg->host->b_hnp_enable)
 			otg_set_state(fsm, OTG_STATE_A_PERIPHERAL);
-		else if (!fsm->b_conn && !fsm->otg->host->b_hnp_enable)
+		else if (!fsm->b_conn && !otg->host->b_hnp_enable)
 			otg_set_state(fsm, OTG_STATE_A_WAIT_BCON);
 		else if (fsm->a_bus_req || fsm->b_bus_resume)
 			otg_set_state(fsm, OTG_STATE_A_HOST);
diff --git a/drivers/usb/phy/phy-fsl-usb.c b/drivers/usb/phy/phy-fsl-usb.c
index c57ef5c..a18a2ee 100644
--- a/drivers/usb/phy/phy-fsl-usb.c
+++ b/drivers/usb/phy/phy-fsl-usb.c
@@ -127,7 +127,7 @@ int write_ulpi(u8 addr, u8 data)
 /* Operations that will be called from OTG Finite State Machine */
 
 /* Charge vbus for vbus pulsing in SRP */
-void fsl_otg_chrg_vbus(struct otg_fsm *fsm, int on)
+void fsl_otg_chrg_vbus(struct usb_otg *otg, int on)
 {
 	u32 tmp;
 
@@ -163,7 +163,7 @@ void fsl_otg_dischrg_vbus(int on)
 }
 
 /* A-device driver vbus, controlled through PP bit in PORTSC */
-void fsl_otg_drv_vbus(struct otg_fsm *fsm, int on)
+void fsl_otg_drv_vbus(struct usb_otg *otg, int on)
 {
 	u32 tmp;
 
@@ -181,7 +181,7 @@ void fsl_otg_drv_vbus(struct otg_fsm *fsm, int on)
  * Pull-up D+, signalling connect by periperal. Also used in
  * data-line pulsing in SRP
  */
-void fsl_otg_loc_conn(struct otg_fsm *fsm, int on)
+void fsl_otg_loc_conn(struct usb_otg *otg, int on)
 {
 	u32 tmp;
 
@@ -200,7 +200,7 @@ void fsl_otg_loc_conn(struct otg_fsm *fsm, int on)
  * port.  In host mode, controller will automatically send SOF.
  * Suspend will block the data on the port.
  */
-void fsl_otg_loc_sof(struct otg_fsm *fsm, int on)
+void fsl_otg_loc_sof(struct usb_otg *otg, int on)
 {
 	u32 tmp;
 
@@ -215,7 +215,7 @@ void fsl_otg_loc_sof(struct otg_fsm *fsm, int on)
 }
 
 /* Start SRP pulsing by data-line pulsing, followed with v-bus pulsing. */
-void fsl_otg_start_pulse(struct otg_fsm *fsm)
+void fsl_otg_start_pulse(struct usb_otg *otg)
 {
 	u32 tmp;
 
@@ -228,7 +228,7 @@ void fsl_otg_start_pulse(struct otg_fsm *fsm)
 	fsl_otg_loc_conn(1);
 #endif
 
-	fsl_otg_add_timer(fsm, b_data_pulse_tmr);
+	fsl_otg_add_timer(&otg->fsm, b_data_pulse_tmr);
 }
 
 void b_data_pulse_end(unsigned long foo)
@@ -245,14 +245,14 @@ void b_data_pulse_end(unsigned long foo)
 void fsl_otg_pulse_vbus(void)
 {
 	srp_wait_done = 0;
-	fsl_otg_chrg_vbus(&fsl_otg_dev->fsm, 1);
+	fsl_otg_chrg_vbus(&fsl_otg_dev->otg, 1);
 	/* start the timer to end vbus charge */
-	fsl_otg_add_timer(&fsl_otg_dev->fsm, b_vbus_pulse_tmr);
+	fsl_otg_add_timer(&fsl_otg_dev->otg.fsm, b_vbus_pulse_tmr);
 }
 
 void b_vbus_pulse_end(unsigned long foo)
 {
-	fsl_otg_chrg_vbus(&fsl_otg_dev->fsm, 0);
+	fsl_otg_chrg_vbus(&fsl_otg_dev->otg, 0);
 
 	/*
 	 * As USB3300 using the same a_sess_vld and b_sess_vld voltage
@@ -260,7 +260,7 @@ void b_vbus_pulse_end(unsigned long foo)
 	 * residual voltage of vbus pulsing and A device pull up
 	 */
 	fsl_otg_dischrg_vbus(1);
-	fsl_otg_add_timer(&fsl_otg_dev->fsm, b_srp_wait_tmr);
+	fsl_otg_add_timer(&fsl_otg_dev->otg.fsm, b_srp_wait_tmr);
 }
 
 void b_srp_end(unsigned long foo)
@@ -269,8 +269,8 @@ void b_srp_end(unsigned long foo)
 	srp_wait_done = 1;
 
 	if ((fsl_otg_dev->phy.otg->state == OTG_STATE_B_SRP_INIT) &&
-	    fsl_otg_dev->fsm.b_sess_vld)
-		fsl_otg_dev->fsm.b_srp_done = 1;
+	    fsl_otg_dev->otg.fsm.b_sess_vld)
+		fsl_otg_dev->otg.fsm.b_srp_done = 1;
 }
 
 /*
@@ -282,9 +282,9 @@ void a_wait_enum(unsigned long foo)
 {
 	VDBG("a_wait_enum timeout\n");
 	if (!fsl_otg_dev->phy.otg->host->b_hnp_enable)
-		fsl_otg_add_timer(&fsl_otg_dev->fsm, a_wait_enum_tmr);
+		fsl_otg_add_timer(&fsl_otg_dev->otg.fsm, a_wait_enum_tmr);
 	else
-		otg_statemachine(&fsl_otg_dev->fsm);
+		otg_statemachine(&fsl_otg_dev->otg);
 }
 
 /* The timeout callback function to set time out bit */
@@ -421,7 +421,7 @@ void fsl_otg_add_timer(struct otg_fsm *fsm, void *gtimer)
 	list_add_tail(&timer->list, &active_timers);
 }
 
-static void fsl_otg_fsm_add_timer(struct otg_fsm *fsm, enum otg_fsm_timer t)
+static void fsl_otg_fsm_add_timer(struct usb_otg *otg, enum otg_fsm_timer t)
 {
 	struct fsl_otg_timer *timer;
 
@@ -429,7 +429,7 @@ static void fsl_otg_fsm_add_timer(struct otg_fsm *fsm, enum otg_fsm_timer t)
 	if (!timer)
 		return;
 
-	fsl_otg_add_timer(fsm, timer);
+	fsl_otg_add_timer(&otg->fsm, timer);
 }
 
 /* Remove timer from the timer list; clear timeout status */
@@ -443,7 +443,7 @@ void fsl_otg_del_timer(struct otg_fsm *fsm, void *gtimer)
 			list_del(&timer->list);
 }
 
-static void fsl_otg_fsm_del_timer(struct otg_fsm *fsm, enum otg_fsm_timer t)
+static void fsl_otg_fsm_del_timer(struct usb_otg *otg, enum otg_fsm_timer t)
 {
 	struct fsl_otg_timer *timer;
 
@@ -451,7 +451,7 @@ static void fsl_otg_fsm_del_timer(struct otg_fsm *fsm, enum otg_fsm_timer t)
 	if (!timer)
 		return;
 
-	fsl_otg_del_timer(fsm, timer);
+	fsl_otg_del_timer(&otg->fsm, timer);
 }
 
 /* Reset controller, not reset the bus */
@@ -467,9 +467,9 @@ void otg_reset_controller(void)
 }
 
 /* Call suspend/resume routines in host driver */
-int fsl_otg_start_host(struct otg_fsm *fsm, int on)
+int fsl_otg_start_host(struct usb_otg *otg, int on)
 {
-	struct usb_otg *otg = fsm->otg;
+	struct otg_fsm *fsm = &otg->fsm;
 	struct device *dev;
 	struct fsl_otg *otg_dev =
 		container_of(otg->usb_phy, struct fsl_otg, phy);
@@ -496,7 +496,7 @@ int fsl_otg_start_host(struct otg_fsm *fsm, int on)
 				retval = dev->driver->pm->resume(dev);
 				if (fsm->id) {
 					/* default-b */
-					fsl_otg_drv_vbus(fsm, 1);
+					fsl_otg_drv_vbus(otg, 1);
 					/*
 					 * Workaround: b_host can't driver
 					 * vbus, but PP in PORTSC needs to
@@ -521,7 +521,7 @@ int fsl_otg_start_host(struct otg_fsm *fsm, int on)
 					retval = dev->driver->pm->suspend(dev);
 				if (fsm->id)
 					/* default-b */
-					fsl_otg_drv_vbus(fsm, 0);
+					fsl_otg_drv_vbus(otg, 0);
 			}
 			otg_dev->host_working = 0;
 		}
@@ -534,9 +534,8 @@ end:
  * Call suspend and resume function in udc driver
  * to stop and start udc driver.
  */
-int fsl_otg_start_gadget(struct otg_fsm *fsm, int on)
+int fsl_otg_start_gadget(struct usb_otg *otg, int on)
 {
-	struct usb_otg *otg = fsm->otg;
 	struct device *dev;
 
 	if (!otg->gadget || !otg->gadget->dev.parent)
@@ -573,14 +572,14 @@ static int fsl_otg_set_host(struct usb_otg *otg, struct usb_bus *host)
 
 	otg->host = host;
 
-	otg_dev->fsm.a_bus_drop = 0;
-	otg_dev->fsm.a_bus_req = 1;
+	otg->fsm.a_bus_drop = 0;
+	otg->fsm.a_bus_req = 1;
 
 	if (host) {
 		VDBG("host off......\n");
 
 		otg->host->otg_port = fsl_otg_initdata.otg_port;
-		otg->host->is_b_host = otg_dev->fsm.id;
+		otg->host->is_b_host = otg->fsm.id;
 		/*
 		 * must leave time for hub_wq to finish its thing
 		 * before yanking the host driver out from under it,
@@ -594,7 +593,7 @@ static int fsl_otg_set_host(struct usb_otg *otg, struct usb_bus *host)
 		if (!(fsl_readl(&otg_dev->dr_mem_map->otgsc) &
 		      OTGSC_STS_USB_ID)) {
 			/* Mini-A cable connected */
-			struct otg_fsm *fsm = &otg_dev->fsm;
+			struct otg_fsm *fsm = &otg->fsm;
 
 			otg->state = OTG_STATE_UNDEFINED;
 			fsm->protocol = PROTO_UNDEF;
@@ -603,7 +602,7 @@ static int fsl_otg_set_host(struct usb_otg *otg, struct usb_bus *host)
 
 	otg_dev->host_working = 0;
 
-	otg_statemachine(&otg_dev->fsm);
+	otg_statemachine(otg);
 
 	return 0;
 }
@@ -628,22 +627,22 @@ static int fsl_otg_set_peripheral(struct usb_otg *otg,
 			otg->gadget->ops->vbus_draw(otg->gadget, 0);
 		usb_gadget_vbus_disconnect(otg->gadget);
 		otg->gadget = 0;
-		otg_dev->fsm.b_bus_req = 0;
-		otg_statemachine(&otg_dev->fsm);
+		otg->fsm.b_bus_req = 0;
+		otg_statemachine(otg);
 		return 0;
 	}
 
 	otg->gadget = gadget;
-	otg->gadget->is_a_peripheral = !otg_dev->fsm.id;
+	otg->gadget->is_a_peripheral = !otg->fsm.id;
 
-	otg_dev->fsm.b_bus_req = 1;
+	otg->fsm.b_bus_req = 1;
 
 	/* start the gadget right away if the ID pin says Mini-B */
-	pr_debug("ID pin=%d\n", otg_dev->fsm.id);
-	if (otg_dev->fsm.id == 1) {
-		fsl_otg_start_host(&otg_dev->fsm, 0);
-		otg_drv_vbus(&otg_dev->fsm, 0);
-		fsl_otg_start_gadget(&otg_dev->fsm, 1);
+	pr_debug("ID pin=%d\n", otg->fsm.id);
+	if (otg->fsm.id == 1) {
+		fsl_otg_start_host(otg, 0);
+		otg_drv_vbus(otg, 0);
+		fsl_otg_start_gadget(otg, 1);
 	}
 
 	return 0;
@@ -672,13 +671,14 @@ static int fsl_otg_set_power(struct usb_phy *phy, unsigned mA)
  */
 static void fsl_otg_event(struct work_struct *work)
 {
-	struct fsl_otg *og = container_of(work, struct fsl_otg, otg_event.work);
-	struct otg_fsm *fsm = &og->fsm;
-
-	if (fsm->id) {		/* switch to gadget */
-		fsl_otg_start_host(fsm, 0);
-		otg_drv_vbus(fsm, 0);
-		fsl_otg_start_gadget(fsm, 1);
+	struct fsl_otg *fotg = container_of(work, struct fsl_otg,
+					    otg_event.work);
+	struct usb_otg *otg = &fotg->otg;
+
+	if (otg->fsm.id) {		/* switch to gadget */
+		fsl_otg_start_host(otg, 0);
+		otg_drv_vbus(otg, 0);
+		fsl_otg_start_gadget(otg, 1);
 	}
 }
 
@@ -694,8 +694,8 @@ static int fsl_otg_start_srp(struct usb_otg *otg)
 	if (otg_dev != fsl_otg_dev)
 		return -ENODEV;
 
-	otg_dev->fsm.b_bus_req = 1;
-	otg_statemachine(&otg_dev->fsm);
+	otg->fsm.b_bus_req = 1;
+	otg_statemachine(otg);
 
 	return 0;
 }
@@ -715,8 +715,8 @@ static int fsl_otg_start_hnp(struct usb_otg *otg)
 	pr_debug("start_hnp...\n");
 
 	/* clear a_bus_req to enter a_suspend state */
-	otg_dev->fsm.a_bus_req = 0;
-	otg_statemachine(&otg_dev->fsm);
+	otg->fsm.a_bus_req = 0;
+	otg_statemachine(otg);
 
 	return 0;
 }
@@ -729,8 +729,8 @@ static int fsl_otg_start_hnp(struct usb_otg *otg)
  */
 irqreturn_t fsl_otg_isr(int irq, void *dev_id)
 {
-	struct otg_fsm *fsm = &((struct fsl_otg *)dev_id)->fsm;
-	struct usb_otg *otg = ((struct fsl_otg *)dev_id)->phy.otg;
+	struct usb_otg *otg = &((struct fsl_otg *)dev_id)->otg;
+	struct otg_fsm *fsm = &otg->fsm;
 	u32 otg_int_src, otg_sc;
 
 	otg_sc = fsl_readl(&usb_dr_regs->otgsc);
@@ -768,9 +768,9 @@ irqreturn_t fsl_otg_isr(int irq, void *dev_id)
 				cancel_delayed_work(&
 						    ((struct fsl_otg *)dev_id)->
 						    otg_event);
-				fsl_otg_start_gadget(fsm, 0);
-				otg_drv_vbus(fsm, 1);
-				fsl_otg_start_host(fsm, 1);
+				fsl_otg_start_gadget(otg, 0);
+				otg_drv_vbus(otg, 1);
+				fsl_otg_start_host(otg, 1);
 			}
 			return IRQ_HANDLED;
 		}
@@ -806,25 +806,21 @@ static int fsl_otg_conf(struct platform_device *pdev)
 	if (!fsl_otg_tc)
 		return -ENOMEM;
 
-	fsl_otg_tc->phy.otg = kzalloc(sizeof(struct usb_otg), GFP_KERNEL);
-	if (!fsl_otg_tc->phy.otg) {
-		kfree(fsl_otg_tc);
-		return -ENOMEM;
-	}
+	fsl_otg_tc->phy.otg = &fsl_otg_tc->otg;
 
 	INIT_DELAYED_WORK(&fsl_otg_tc->otg_event, fsl_otg_event);
 
 	INIT_LIST_HEAD(&active_timers);
-	status = fsl_otg_init_timers(&fsl_otg_tc->fsm);
+	status = fsl_otg_init_timers(&fsl_otg_tc->otg.fsm);
 	if (status) {
 		pr_info("Couldn't init OTG timers\n");
 		goto err;
 	}
-	mutex_init(&fsl_otg_tc->fsm.lock);
+	mutex_init(&fsl_otg_tc->otg.fsm.lock);
 
 	/* Set OTG state machine operations */
-	fsl_otg_tc->fsm.ops = &fsl_otg_ops;
-	fsl_otg_tc->fsm.dev = &pdev->dev;
+	fsl_otg_tc->otg.fsm.ops = &fsl_otg_ops;
+	fsl_otg_tc->otg.fsm.dev = &pdev->dev;
 
 	/* initialize the otg structure */
 	fsl_otg_tc->phy.label = DRIVER_DESC;
@@ -859,18 +855,15 @@ int usb_otg_start(struct platform_device *pdev)
 {
 	struct fsl_otg *p_otg;
 	struct usb_phy *otg_trans = usb_get_phy(USB_PHY_TYPE_USB2);
-	struct otg_fsm *fsm;
 	int status;
 	struct resource *res;
 	u32 temp;
 	struct fsl_usb2_platform_data *pdata = dev_get_platdata(&pdev->dev);
 
 	p_otg = container_of(otg_trans, struct fsl_otg, phy);
-	fsm = &p_otg->fsm;
 
 	/* Initialize the state machine structure with default values */
 	SET_OTG_STATE(otg_trans, OTG_STATE_UNDEFINED);
-	fsm->otg = p_otg->phy.otg;
 
 	/* We don't require predefined MEM/IRQ resource index */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -964,13 +957,13 @@ int usb_otg_start(struct platform_device *pdev)
 	 */
 	if (fsl_readl(&p_otg->dr_mem_map->otgsc) & OTGSC_STS_USB_ID) {
 		p_otg->phy.otg->state = OTG_STATE_UNDEFINED;
-		p_otg->fsm.id = 1;
+		p_otg->otg.fsm.id = 1;
 	} else {
 		p_otg->phy.otg->state = OTG_STATE_A_IDLE;
-		p_otg->fsm.id = 0;
+		p_otg->otg.fsm.id = 0;
 	}
 
-	pr_debug("initial ID pin=%d\n", p_otg->fsm.id);
+	pr_debug("initial ID pin=%d\n", p_otg->otg.fsm.id);
 
 	/* enable OTG ID pin interrupt */
 	temp = fsl_readl(&p_otg->dr_mem_map->otgsc);
@@ -987,7 +980,7 @@ int usb_otg_start(struct platform_device *pdev)
 static int show_fsl_usb2_otg_state(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
-	struct otg_fsm *fsm = &fsl_otg_dev->fsm;
+	struct otg_fsm *fsm = &fsl_otg_dev->otg.fsm;
 	char *next = buf;
 	unsigned size = PAGE_SIZE;
 	int t;
@@ -1085,26 +1078,26 @@ static long fsl_otg_ioctl(struct file *file, unsigned int cmd,
 		break;
 
 	case SET_A_SUSPEND_REQ:
-		fsl_otg_dev->fsm.a_suspend_req_inf = arg;
+		fsl_otg_dev->otg.fsm.a_suspend_req_inf = arg;
 		break;
 
 	case SET_A_BUS_DROP:
-		fsl_otg_dev->fsm.a_bus_drop = arg;
+		fsl_otg_dev->otg.fsm.a_bus_drop = arg;
 		break;
 
 	case SET_A_BUS_REQ:
-		fsl_otg_dev->fsm.a_bus_req = arg;
+		fsl_otg_dev->otg.fsm.a_bus_req = arg;
 		break;
 
 	case SET_B_BUS_REQ:
-		fsl_otg_dev->fsm.b_bus_req = arg;
+		fsl_otg_dev->otg.fsm.b_bus_req = arg;
 		break;
 
 	default:
 		break;
 	}
 
-	otg_statemachine(&fsl_otg_dev->fsm);
+	otg_statemachine(&fsl_otg_dev->otg);
 
 	return retval;
 }
diff --git a/drivers/usb/phy/phy-fsl-usb.h b/drivers/usb/phy/phy-fsl-usb.h
index 2314995..e207cfb 100644
--- a/drivers/usb/phy/phy-fsl-usb.h
+++ b/drivers/usb/phy/phy-fsl-usb.h
@@ -15,7 +15,6 @@
  * 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#include <linux/usb/otg-fsm.h>
 #include <linux/usb/otg.h>
 #include <linux/ioctl.h>
 
@@ -370,7 +369,7 @@ inline struct fsl_otg_timer *otg_timer_initializer
 
 struct fsl_otg {
 	struct usb_phy phy;
-	struct otg_fsm fsm;
+	struct usb_otg otg;
 	struct usb_dr_mmap *dr_mem_map;
 	struct delayed_work otg_event;
 
diff --git a/include/linux/usb/otg-fsm.h b/include/linux/usb/otg-fsm.h
index 47b8392..36f0cf9 100644
--- a/include/linux/usb/otg-fsm.h
+++ b/include/linux/usb/otg-fsm.h
@@ -189,7 +189,6 @@ struct otg_fsm {
 	int a_bidl_adis_tmout;
 
 	struct otg_fsm_ops *ops;
-	struct usb_otg *otg;
 
 	/* Current usb protocol used: 0:undefine; 1:host; 2:client */
 	int protocol;
@@ -202,126 +201,23 @@ struct otg_fsm {
 	struct device *dev;
 };
 
+struct usb_otg;
+
 struct otg_fsm_ops {
-	void	(*chrg_vbus)(struct otg_fsm *fsm, int on);
-	void	(*drv_vbus)(struct otg_fsm *fsm, int on);
-	void	(*loc_conn)(struct otg_fsm *fsm, int on);
-	void	(*loc_sof)(struct otg_fsm *fsm, int on);
-	void	(*start_pulse)(struct otg_fsm *fsm);
-	void	(*start_adp_prb)(struct otg_fsm *fsm);
-	void	(*start_adp_sns)(struct otg_fsm *fsm);
-	void	(*add_timer)(struct otg_fsm *fsm, enum otg_fsm_timer timer);
-	void	(*del_timer)(struct otg_fsm *fsm, enum otg_fsm_timer timer);
-	int	(*start_host)(struct otg_fsm *fsm, int on);
-	int	(*start_gadget)(struct otg_fsm *fsm, int on);
+	void	(*chrg_vbus)(struct usb_otg *otg, int on);
+	void	(*drv_vbus)(struct usb_otg *otg, int on);
+	void	(*loc_conn)(struct usb_otg *otg, int on);
+	void	(*loc_sof)(struct usb_otg *otg, int on);
+	void	(*start_pulse)(struct usb_otg *otg);
+	void	(*start_adp_prb)(struct usb_otg *otg);
+	void	(*start_adp_sns)(struct usb_otg *otg);
+	void	(*add_timer)(struct usb_otg *otg, enum otg_fsm_timer timer);
+	void	(*del_timer)(struct usb_otg *otg, enum otg_fsm_timer timer);
+	int	(*start_host)(struct usb_otg *otg, int on);
+	int	(*start_gadget)(struct usb_otg *otg, int on);
 };
 
 
-static inline int otg_chrg_vbus(struct otg_fsm *fsm, int on)
-{
-	if (!fsm->ops->chrg_vbus)
-		return -EOPNOTSUPP;
-	fsm->ops->chrg_vbus(fsm, on);
-	return 0;
-}
-
-static inline int otg_drv_vbus(struct otg_fsm *fsm, int on)
-{
-	if (!fsm->ops->drv_vbus)
-		return -EOPNOTSUPP;
-	if (fsm->drv_vbus != on) {
-		fsm->drv_vbus = on;
-		fsm->ops->drv_vbus(fsm, on);
-	}
-	return 0;
-}
-
-static inline int otg_loc_conn(struct otg_fsm *fsm, int on)
-{
-	if (!fsm->ops->loc_conn)
-		return -EOPNOTSUPP;
-	if (fsm->loc_conn != on) {
-		fsm->loc_conn = on;
-		fsm->ops->loc_conn(fsm, on);
-	}
-	return 0;
-}
-
-static inline int otg_loc_sof(struct otg_fsm *fsm, int on)
-{
-	if (!fsm->ops->loc_sof)
-		return -EOPNOTSUPP;
-	if (fsm->loc_sof != on) {
-		fsm->loc_sof = on;
-		fsm->ops->loc_sof(fsm, on);
-	}
-	return 0;
-}
-
-static inline int otg_start_pulse(struct otg_fsm *fsm)
-{
-	if (!fsm->ops->start_pulse)
-		return -EOPNOTSUPP;
-	if (!fsm->data_pulse) {
-		fsm->data_pulse = 1;
-		fsm->ops->start_pulse(fsm);
-	}
-	return 0;
-}
-
-static inline int otg_start_adp_prb(struct otg_fsm *fsm)
-{
-	if (!fsm->ops->start_adp_prb)
-		return -EOPNOTSUPP;
-	if (!fsm->adp_prb) {
-		fsm->adp_sns = 0;
-		fsm->adp_prb = 1;
-		fsm->ops->start_adp_prb(fsm);
-	}
-	return 0;
-}
-
-static inline int otg_start_adp_sns(struct otg_fsm *fsm)
-{
-	if (!fsm->ops->start_adp_sns)
-		return -EOPNOTSUPP;
-	if (!fsm->adp_sns) {
-		fsm->adp_sns = 1;
-		fsm->ops->start_adp_sns(fsm);
-	}
-	return 0;
-}
-
-static inline int otg_add_timer(struct otg_fsm *fsm, enum otg_fsm_timer timer)
-{
-	if (!fsm->ops->add_timer)
-		return -EOPNOTSUPP;
-	fsm->ops->add_timer(fsm, timer);
-	return 0;
-}
-
-static inline int otg_del_timer(struct otg_fsm *fsm, enum otg_fsm_timer timer)
-{
-	if (!fsm->ops->del_timer)
-		return -EOPNOTSUPP;
-	fsm->ops->del_timer(fsm, timer);
-	return 0;
-}
-
-static inline int otg_start_host(struct otg_fsm *fsm, int on)
-{
-	if (!fsm->ops->start_host)
-		return -EOPNOTSUPP;
-	return fsm->ops->start_host(fsm, on);
-}
-
-static inline int otg_start_gadget(struct otg_fsm *fsm, int on)
-{
-	if (!fsm->ops->start_gadget)
-		return -EOPNOTSUPP;
-	return fsm->ops->start_gadget(fsm, on);
-}
-
-int otg_statemachine(struct otg_fsm *fsm);
+int otg_statemachine(struct usb_otg *otg);
 
 #endif /* __LINUX_USB_OTG_FSM_H */
diff --git a/include/linux/usb/otg.h b/include/linux/usb/otg.h
index 67929df..e8a14dc 100644
--- a/include/linux/usb/otg.h
+++ b/include/linux/usb/otg.h
@@ -11,6 +11,7 @@
 
 #include <linux/phy/phy.h>
 #include <linux/usb/phy.h>
+#include <linux/usb/otg-fsm.h>
 
 struct usb_otg {
 	u8			default_a;
@@ -22,6 +23,7 @@ struct usb_otg {
 	struct usb_gadget	*gadget;
 
 	enum usb_otg_state	state;
+	struct otg_fsm fsm;
 
 	/* bind/unbind the host controller */
 	int	(*set_host)(struct usb_otg *otg, struct usb_bus *host);
@@ -128,4 +130,109 @@ enum usb_dr_mode {
  */
 extern enum usb_dr_mode usb_get_dr_mode(struct device *dev);
 
+static inline int otg_chrg_vbus(struct usb_otg *otg, int on)
+{
+	if (!otg->fsm.ops->chrg_vbus)
+		return -EOPNOTSUPP;
+	otg->fsm.ops->chrg_vbus(otg, on);
+	return 0;
+}
+
+static inline int otg_drv_vbus(struct usb_otg *otg, int on)
+{
+	if (!otg->fsm.ops->drv_vbus)
+		return -EOPNOTSUPP;
+	if (otg->fsm.drv_vbus != on) {
+		otg->fsm.drv_vbus = on;
+		otg->fsm.ops->drv_vbus(otg, on);
+	}
+	return 0;
+}
+
+static inline int otg_loc_conn(struct usb_otg *otg, int on)
+{
+	if (!otg->fsm.ops->loc_conn)
+		return -EOPNOTSUPP;
+	if (otg->fsm.loc_conn != on) {
+		otg->fsm.loc_conn = on;
+		otg->fsm.ops->loc_conn(otg, on);
+	}
+	return 0;
+}
+
+static inline int otg_loc_sof(struct usb_otg *otg, int on)
+{
+	if (!otg->fsm.ops->loc_sof)
+		return -EOPNOTSUPP;
+	if (otg->fsm.loc_sof != on) {
+		otg->fsm.loc_sof = on;
+		otg->fsm.ops->loc_sof(otg, on);
+	}
+	return 0;
+}
+
+static inline int otg_start_pulse(struct usb_otg *otg)
+{
+	if (!otg->fsm.ops->start_pulse)
+		return -EOPNOTSUPP;
+	if (!otg->fsm.data_pulse) {
+		otg->fsm.data_pulse = 1;
+		otg->fsm.ops->start_pulse(otg);
+	}
+	return 0;
+}
+
+static inline int otg_start_adp_prb(struct usb_otg *otg)
+{
+	if (!otg->fsm.ops->start_adp_prb)
+		return -EOPNOTSUPP;
+	if (!otg->fsm.adp_prb) {
+		otg->fsm.adp_sns = 0;
+		otg->fsm.adp_prb = 1;
+		otg->fsm.ops->start_adp_prb(otg);
+	}
+	return 0;
+}
+
+static inline int otg_start_adp_sns(struct usb_otg *otg)
+{
+	if (!otg->fsm.ops->start_adp_sns)
+		return -EOPNOTSUPP;
+	if (!otg->fsm.adp_sns) {
+		otg->fsm.adp_sns = 1;
+		otg->fsm.ops->start_adp_sns(otg);
+	}
+	return 0;
+}
+
+static inline int otg_add_timer(struct usb_otg *otg, enum otg_fsm_timer timer)
+{
+	if (!otg->fsm.ops->add_timer)
+		return -EOPNOTSUPP;
+	otg->fsm.ops->add_timer(otg, timer);
+	return 0;
+}
+
+static inline int otg_del_timer(struct usb_otg *otg, enum otg_fsm_timer timer)
+{
+	if (!otg->fsm.ops->del_timer)
+		return -EOPNOTSUPP;
+	otg->fsm.ops->del_timer(otg, timer);
+	return 0;
+}
+
+static inline int otg_start_host(struct usb_otg *otg, int on)
+{
+	if (!otg->fsm.ops->start_host)
+		return -EOPNOTSUPP;
+	return otg->fsm.ops->start_host(otg, on);
+}
+
+static inline int otg_start_gadget(struct usb_otg *otg, int on)
+{
+	if (!otg->fsm.ops->start_gadget)
+		return -EOPNOTSUPP;
+	return otg->fsm.ops->start_gadget(otg, on);
+}
+
 #endif /* __LINUX_USB_OTG_H */
-- 
2.5.0
