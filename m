From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 32/36] musb_hdrc: Search and replace bReg with reg
Date: Thu, 16 Aug 2007 02:40:55 -0700
Message-ID: <1187257334140-git-send-email-tony@atomide.com>
References: <11872572591844-git-send-email-tony@atomide.com>
	<11872572612810-git-send-email-tony@atomide.com>
	<11872572643880-git-send-email-tony@atomide.com>
	<11872572672740-git-send-email-tony@atomide.com>
	<11872572693807-git-send-email-tony@atomide.com>
	<11872572713057-git-send-email-tony@atomide.com>
	<11872572743878-git-send-email-tony@atomide.com>
	<11872572762670-git-send-email-tony@atomide.com>
	<1187257278289-git-send-email-tony@atomide.com>
	<11872572803477-git-send-email-tony@atomide.com>
	<1187257282941-git-send-email-tony@atomide.com>
	<11872572842479-git-send-email-tony@atomide.com>
	<11872572872790-git-send-email-tony@atomide.com>
	<11872572893163-git-send-email-tony@atomide.com>
	<1187257291525-git-send-email-tony@atomide.com>
	<1187257294890-git-send-email-tony@atomide.com>
	<11872572962771-git-send-email-tony@atomide.com>
	<11872572981150-git-send-email-tony@atomide.com>
	<1187257301587-git-send-email-tony@atomide.com>
	<1187257303715-git-send-email-tony@atomide.com>
	<11872573062287-git-send-email-tony@atomide.com>
	<11872573092269-git-send-email-tony@atomide.com>
	<1187257311394-git-send-email-tony@atomide.com>
	<11872573133142-git-send-email-tony@atomide.com>
	<11872573161558-git-send-email-tony@atomide.com>
	<1187257318333-git-send-email-tony@atomide.com>
	<11872573202855-git-send-email-tony@atomide.com>
	<11872573222937-git-send-email-tony@atomide.com>
	<1187257324463-git-send-email-tony@atomide.com>
	<11872573273963-git-send-email-tony@atomide.com>
	<1187257329166-git-send-email-tony@atomide.com>
	<118725733255-git-send-email-tony@atomide.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <118725733255-git-send-email-tony@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Search and replace bReg with reg

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/musb_procfs.c |   36 ++++++++++++++++++------------------
 1 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/usb/musb/musb_procfs.c b/drivers/usb/musb/musb_procfs.c
index 535c6e8..8833604 100644
--- a/drivers/usb/musb/musb_procfs.c
+++ b/drivers/usb/musb/musb_procfs.c
@@ -652,7 +652,7 @@ static int musb_proc_write(struct file *file, const char __user *buffer,
 			unsigned long count, void *data)
 {
 	char cmd;
-	u8 bReg;
+	u8 reg;
 	struct musb *musb = (struct musb *)data;
 	void __iomem *mbase = musb->mregs;
 
@@ -664,47 +664,47 @@ static int musb_proc_write(struct file *file, const char __user *buffer,
 	switch (cmd) {
 	case 'C':
 		if (mbase) {
-			bReg = musb_readb(mbase, MUSB_POWER)
+			reg = musb_readb(mbase, MUSB_POWER)
 					| MUSB_POWER_SOFTCONN;
-			musb_writeb(mbase, MUSB_POWER, bReg);
+			musb_writeb(mbase, MUSB_POWER, reg);
 		}
 		break;
 
 	case 'c':
 		if (mbase) {
-			bReg = musb_readb(mbase, MUSB_POWER)
+			reg = musb_readb(mbase, MUSB_POWER)
 					& ~MUSB_POWER_SOFTCONN;
-			musb_writeb(mbase, MUSB_POWER, bReg);
+			musb_writeb(mbase, MUSB_POWER, reg);
 		}
 		break;
 
 	case 'I':
 		if (mbase) {
-			bReg = musb_readb(mbase, MUSB_POWER)
+			reg = musb_readb(mbase, MUSB_POWER)
 					| MUSB_POWER_HSENAB;
-			musb_writeb(mbase, MUSB_POWER, bReg);
+			musb_writeb(mbase, MUSB_POWER, reg);
 		}
 		break;
 
 	case 'i':
 		if (mbase) {
-			bReg = musb_readb(mbase, MUSB_POWER)
+			reg = musb_readb(mbase, MUSB_POWER)
 					& ~MUSB_POWER_HSENAB;
-			musb_writeb(mbase, MUSB_POWER, bReg);
+			musb_writeb(mbase, MUSB_POWER, reg);
 		}
 		break;
 
 	case 'F':
-		bReg = musb_readb(mbase, MUSB_DEVCTL);
-		bReg |= MUSB_DEVCTL_SESSION;
-		musb_writeb(mbase, MUSB_DEVCTL, bReg);
+		reg = musb_readb(mbase, MUSB_DEVCTL);
+		reg |= MUSB_DEVCTL_SESSION;
+		musb_writeb(mbase, MUSB_DEVCTL, reg);
 		break;
 
 	case 'H':
 		if (mbase) {
-			bReg = musb_readb(mbase, MUSB_DEVCTL);
-			bReg |= MUSB_DEVCTL_HR;
-			musb_writeb(mbase, MUSB_DEVCTL, bReg);
+			reg = musb_readb(mbase, MUSB_DEVCTL);
+			reg |= MUSB_DEVCTL_HR;
+			musb_writeb(mbase, MUSB_DEVCTL, reg);
 			//MUSB_HST_MODE( ((struct musb*)data) );
 			//WARN("Host Mode\n");
 		}
@@ -712,9 +712,9 @@ static int musb_proc_write(struct file *file, const char __user *buffer,
 
 	case 'h':
 		if (mbase) {
-			bReg = musb_readb(mbase, MUSB_DEVCTL);
-			bReg &= ~MUSB_DEVCTL_HR;
-			musb_writeb(mbase, MUSB_DEVCTL, bReg);
+			reg = musb_readb(mbase, MUSB_DEVCTL);
+			reg &= ~MUSB_DEVCTL_HR;
+			musb_writeb(mbase, MUSB_DEVCTL, reg);
 		}
 		break;
 
-- 
1.5.2.3
