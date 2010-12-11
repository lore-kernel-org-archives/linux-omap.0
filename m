From: Peter Barada <peterb@logicpd.com>
Subject: Problem trying to measure OMAP35x core temperature
Date: Sat, 11 Dec 2010 16:14:54 -0500
Message-ID: <4D03E9CE.1090708@logicpd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 174-46-170-154.static.twtelecom.net ([174.46.170.154]:52499
	"EHLO edprlnx06.logicpd.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751432Ab0LKVOy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 11 Dec 2010 16:14:54 -0500
Received: from [10.1.249.2] (unknown [10.1.249.2])
	by edprlnx06.logicpd.com (Postfix) with ESMTP id 983C460009B
	for <linux-omap@vger.kernel.org>; Sat, 11 Dec 2010 15:13:43 -0600 (CST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

I'm trying to add code to a 2.6.32 kernel to extract the OMAP core 
temperature for thermal testing, and section 7.4.6 of the OMAP3 TRM 
(spug98g.pdf) explains the CONTROL_TEMP_SENSOR register.

I've added the following code:

static void omap3logic_fetch_temp(char *temp_buf)
{
     int temp_val;
     unsigned int temp;
     static short temp_table[] = {
         -400, -400, -400, -400,    -400,
         -400, -389, -375, -361, -333, /* 0-9 */
         -318, -304, -290, -275, -261,
         -247, -233, -219, -205, -191, /* 10-19 */
         -177, -163, -149, -134, -120,
         -106,  -92,  -78,  -64,  -50, /* 20-29 */
         -35,   -21,   -7,   +8,  +23,
         +37,   +51,  +66,  +80,  +94, /* 30-39 */
         +108, +123, +137, +151, +165,
         +179, +194, +208, +222, +236, /* 40-49 */
         +251, +265, +279, +293, +307,
         +321, +335, +349, +364, +378, /* 50-59 */
         +392, +406, +420, +424, +449,
         +463, +447, +491, +505, +519, /* 60-69 */
         +533, +546, +560, +574, +588,
         +602, +616, +630, +644, +657, /* 70-79 */
         +671, +685, +699, +713, +727,
         +741, +755, +769, +783, +797, /* 80-89 */
         +811, +823, +838, +852, +865,
         +879, +893, +906, +920, +934, /* 90-99 */
         +947, +961, +975, +989, +1002,
         +1016, +1030, +1043, +1057, +1071, /* 100-109 */
         +1085, +1098, +1112, +1126, +1140,
         +1153, +1167, +1181, +1194, +1208, /* 110-119 */
         +1222, +1235, +1249, +1250, +1250,
         +1250, +1250, +1250, +1250, /* 120-128 */
     };

     temp = omap_ctrl_readl(OMAP343X_CONTROL_TEMP_SENSOR);

     temp_val = (temp_table[temp&0x7f] + temp_table[(temp&0x7f)+1]) / 2;
     sprintf(temp_buf, "%d.%1d (%02x)", temp_val/10, ((unsigned 
int)temp_val)%10, temp);
}

static ssize_t
omap3logic_show_temp(struct class *class, char *buf)
{
     ssize_t retval;
     char temp[128];

     omap3logic_fetch_temp(temp);
     retval = sprintf(buf, "%s\n", temp);
     return retval;
}

static struct class_attribute temp_attr =
     __ATTR(temp, S_IRUGO, omap3logic_show_temp, NULL);

static struct class *omap3logic_temp_class;

void omap3logic_temp_init(void)
{
     int rc;

     omap3logic_temp_class = class_create(THIS_MODULE, "temp");
     if (IS_ERR(omap3logic_temp_class)) {
         printk(KERN_ERR "%s: couldn't create temp class\n", __FUNCTION__);
         return;
     }
     rc = class_create_file(omap3logic_temp_class, &temp_attr);
     if (unlikely(rc)) {
         printk(KERN_ERR "%s: couldn't create temp class file\n", 
__FUNCTION__);
         return;
     }

     /* Set CONTCONV and SOC to start continuous temperature measurements */
     omap_ctrl_writel(0x300, OMAP343X_CONTROL_TEMP_SENSOR);
}

But when I read the register back, I see only a fixed temperature value, 
even if I fire up some video demos to crank up the load.  If I reboot 
I'll see the temperature jump up, but then it stays constant whether I 
increase/decrease the CPU load.

Any ideas why this isn't working?

Thanks in advance!

-- 
Peter Barada
peterb@logicpd.com

