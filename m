From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/4] mfd: motmdm: Add Motorola TS 27.010 serdev modem
 driver for droid4
Date: Tue, 11 Feb 2020 08:44:13 -0800
Message-ID: <20200211164413.GG64767@atomide.com>
References: <20200210040107.10306-1-tony@atomide.com>
 <20200210040107.10306-3-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:54706 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728202AbgBKQoS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Tue, 11 Feb 2020 11:44:18 -0500
Content-Disposition: inline
In-Reply-To: <20200210040107.10306-3-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.cz>, Johan Hovold <johan@kernel.org>, Merlijn Wajer <merlijn@wizzup.org>, Pavel Machek <pavel@ucw.cz>, Peter Hurley <peter@hurleysoftware.com>, Rob Herring <robh@kernel.org>, Sebastian Reichel <sre@kernel.org>, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [200210 04:02]:
> --- /dev/null
> +++ b/drivers/mfd/motorola-mdm.c
...
> +struct motmdm_dlci {
> +	struct gsm_serdev_dlci gsm_dlci;
> +	struct list_head node;
> +	wait_queue_head_t read_queue;
> +	struct kfifo read_fifo;
> +	int line;
> +	u16 id;
> +	int (*send_command)(struct device *dev, struct motmdm_dlci *mot_dlci,
> +			    unsigned long timeout_ms, const unsigned char *cmd,
> +			    size_t cmdlen,
> +			    unsigned char *rsp, size_t rsplen);

Looks like the send_command above is now useless and can be
left out, incremental patch below for reference.

I'll be sending out v3 series of patches after waiting few days
for comments.

Regards,

Tony

8< ------------------
diff --git a/drivers/mfd/motorola-mdm.c b/drivers/mfd/motorola-mdm.c
--- a/drivers/mfd/motorola-mdm.c
+++ b/drivers/mfd/motorola-mdm.c
@@ -92,10 +92,6 @@ struct motmdm_dlci {
 	struct kfifo read_fifo;
 	int line;
 	u16 id;
-	int (*send_command)(struct device *dev, struct motmdm_dlci *mot_dlci,
-			    unsigned long timeout_ms, const unsigned char *cmd,
-			    size_t cmdlen,
-			    unsigned char *rsp, size_t rsplen);
 	struct list_head list;
 	void *privdata;		/* Do not use, internal data */
 	void *drvdata;		/* Available for consumer drivers */
@@ -419,11 +415,11 @@ static int motmdm_write(struct device *dev, struct motmdm_dlci *mot_dlci,
  * Helper for child device drivers to send a command to a DLCI and wait
  * for result with a matching packet ID.
  */
-static int motmdm_dlci_send_command(struct device *dev,
-				    struct motmdm_dlci *mot_dlci,
-				    unsigned long timeout_ms,
-				    const unsigned char *cmd, size_t cmdlen,
-				    unsigned char *rsp, size_t rsplen)
+static int motmdm_send_command(struct device *dev,
+			       struct motmdm_dlci *mot_dlci,
+			       unsigned long timeout_ms,
+			       const unsigned char *cmd, size_t cmdlen,
+			       unsigned char *rsp, size_t rsplen)
 {
 	struct motmdm_response *resp, *tmp;
 	struct list_head *pos, *q;
@@ -502,7 +498,6 @@ static int motmdm_register_dlci(struct device *dev,
 	ddata = gsm_serdev_get_drvdata(dev);
 	gsd = &ddata->gsd;
 	gsm_dlci = &mot_dlci->gsm_dlci;
-	mot_dlci->send_command = motmdm_dlci_send_command;
 	INIT_LIST_HEAD(&mot_dlci->list);
 	init_waitqueue_head(&mot_dlci->read_queue);
 	gsm_dlci->line = mot_dlci->line;
@@ -929,9 +924,8 @@ static int motmdm_check_revision(struct device *dev)
 		goto free_buf;
 
 	while (retries--) {
-		err = motmdm_dlci_send_command(dev, mot_dlci, 1000,
-					       cmd, strlen(cmd),
-					       buf, PAGE_SIZE);
+		err = motmdm_send_command(dev, mot_dlci, 1000, cmd, strlen(cmd),
+					  buf, PAGE_SIZE);
 		if (err >= 0) {
 			msleep(100);
 			break;
-- 
2.25.0
