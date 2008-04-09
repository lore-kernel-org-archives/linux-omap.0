From: "Eduardo Valentin" <edubezval@gmail.com>
Subject: Re: [PATCH 2/5] I2C: TSL2563: Add support for Taos tsl2563 ambient light sensor
Date: Wed, 9 Apr 2008 13:47:25 +0300
Message-ID: <a0580c510804090347m4c6a458fvf1923b203195e710@mail.gmail.com>
References: <1207735765-1356-1-git-send-email-felipe.balbi@nokia.com>
	 <1207735765-1356-2-git-send-email-felipe.balbi@nokia.com>
	 <1207735765-1356-3-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:45666 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753079AbYDIKr2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Apr 2008 06:47:28 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2135858wah.23
        for <linux-omap@vger.kernel.org>; Wed, 09 Apr 2008 03:47:25 -0700 (PDT)
In-Reply-To: <1207735765-1356-3-git-send-email-felipe.balbi@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Mathias Nyman <mathias.nyman@nokia.com>

Hi Balbi and Mathias,

This patch has some style problems. Here is the output of checkpatch:
evalenti@evalenti-desktop:~$
./trees/linux-omap-2.6/scripts/checkpatch.pl mathias.diff
ERROR: do not use assignment in if condition
#314: FILE: drivers/i2c/chips/tsl2563.c:188:
+       if ((ret = tsl2563_write(client, TSL2563_REG_TIMING,

ERROR: do not use assignment in if condition
#328: FILE: drivers/i2c/chips/tsl2563.c:202:
+       if ((ret = tsl2563_set_power(chip, 1)))

ERROR: do not use assignment in if condition
#727: FILE: drivers/i2c/chips/tsl2563.c:601:
+       if (!(chip = kzalloc(sizeof(*chip), GFP_KERNEL)))

ERROR: do not use assignment in if condition
#733: FILE: drivers/i2c/chips/tsl2563.c:607:
+       if ((err = tsl2563_detect(chip))) {

ERROR: do not use assignment in if condition
#738: FILE: drivers/i2c/chips/tsl2563.c:612:
+       if ((err = tsl2563_read_id(chip, &id)))

ERROR: do not use assignment in if condition
#753: FILE: drivers/i2c/chips/tsl2563.c:627:
+       if ((err = tsl2563_configure(chip)))

ERROR: do not use assignment in if condition
#760: FILE: drivers/i2c/chips/tsl2563.c:634:
+       if ((err = tsl2563_register_sysfs(client))) {

ERROR: do not use assignment in if condition
#791: FILE: drivers/i2c/chips/tsl2563.c:665:
+       if ((ret = tsl2563_set_power(chip, 0)))

ERROR: do not use assignment in if condition
#808: FILE: drivers/i2c/chips/tsl2563.c:682:
+       if ((ret = tsl2563_set_power(chip, 1)))

ERROR: do not use assignment in if condition
#811: FILE: drivers/i2c/chips/tsl2563.c:685:
+       if ((ret = tsl2563_configure(chip)))

total: 10 errors, 0 warnings, 756 lines checked

mathias.diff has style problems, please review.  If any of these errors
are false positives report them to the maintainer, see
CHECKPATCH in MAINTAINERS.



On Wed, Apr 9, 2008 at 1:09 PM, Felipe Balbi <felipe.balbi@nokia.com> wrote:
>
> From: Mathias Nyman <mathias.nyman@nokia.com>
>

<snip>

>  +
>  +/*--------------------------------------------------------------*/
>  +/*                      Sysfs interface                         */
>  +/*--------------------------------------------------------------*/

Use correct multiple lines comments style here.

>  +
>  +static ssize_t tsl2563_adc0_show(struct device *dev,
>  +                               struct device_attribute *attr, char *buf)
>  +{

<snip>

>  +
>  +/*--------------------------------------------------------------*/
>  +/*                      Probe, Attach, Remove                   */
>  +/*--------------------------------------------------------------*/

Previous comment applies here as well.

>  +static struct i2c_driver tsl2563_i2c_driver;
>  +

<snip>


Cheers,

-- 
Eduardo Bezerra Valentin
