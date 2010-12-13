From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: Problem trying to measure OMAP35x core temperature
Date: Mon, 13 Dec 2010 09:41:41 +0100
Message-ID: <AANLkTim21V+iE_D8HJs1+eRgZmL4a4FoeuBu=-31kLf0@mail.gmail.com>
References: <4D03E9CE.1090708@logicpd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:46441 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751793Ab0LMIlm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Dec 2010 03:41:42 -0500
Received: by qyk12 with SMTP id 12so5671789qyk.19
        for <linux-omap@vger.kernel.org>; Mon, 13 Dec 2010 00:41:41 -0800 (PST)
In-Reply-To: <4D03E9CE.1090708@logicpd.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Barada <peterb@logicpd.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Sat, Dec 11, 2010 at 10:14 PM, Peter Barada <peterb@logicpd.com> wro=
te:
> I'm trying to add code to a 2.6.32 kernel to extract the OMAP core
> temperature for thermal testing, and section 7.4.6 of the OMAP3 TRM
> (spug98g.pdf) explains the CONTROL_TEMP_SENSOR register.

I have not look at it further but there is some code at
http://thread.gmane.org/gmane.linux.ports.arm.omap/8424/focus=3D8514.

Hope this helps!

Jean

>
> I've added the following code:
>
> static void omap3logic_fetch_temp(char *temp_buf)
> {
> =A0 =A0int temp_val;
> =A0 =A0unsigned int temp;
> =A0 =A0static short temp_table[] =3D {
> =A0 =A0 =A0 =A0-400, -400, -400, -400, =A0 =A0-400,
> =A0 =A0 =A0 =A0-400, -389, -375, -361, -333, /* 0-9 */
> =A0 =A0 =A0 =A0-318, -304, -290, -275, -261,
> =A0 =A0 =A0 =A0-247, -233, -219, -205, -191, /* 10-19 */
> =A0 =A0 =A0 =A0-177, -163, -149, -134, -120,
> =A0 =A0 =A0 =A0-106, =A0-92, =A0-78, =A0-64, =A0-50, /* 20-29 */
> =A0 =A0 =A0 =A0-35, =A0 -21, =A0 -7, =A0 +8, =A0+23,
> =A0 =A0 =A0 =A0+37, =A0 +51, =A0+66, =A0+80, =A0+94, /* 30-39 */
> =A0 =A0 =A0 =A0+108, +123, +137, +151, +165,
> =A0 =A0 =A0 =A0+179, +194, +208, +222, +236, /* 40-49 */
> =A0 =A0 =A0 =A0+251, +265, +279, +293, +307,
> =A0 =A0 =A0 =A0+321, +335, +349, +364, +378, /* 50-59 */
> =A0 =A0 =A0 =A0+392, +406, +420, +424, +449,
> =A0 =A0 =A0 =A0+463, +447, +491, +505, +519, /* 60-69 */
> =A0 =A0 =A0 =A0+533, +546, +560, +574, +588,
> =A0 =A0 =A0 =A0+602, +616, +630, +644, +657, /* 70-79 */
> =A0 =A0 =A0 =A0+671, +685, +699, +713, +727,
> =A0 =A0 =A0 =A0+741, +755, +769, +783, +797, /* 80-89 */
> =A0 =A0 =A0 =A0+811, +823, +838, +852, +865,
> =A0 =A0 =A0 =A0+879, +893, +906, +920, +934, /* 90-99 */
> =A0 =A0 =A0 =A0+947, +961, +975, +989, +1002,
> =A0 =A0 =A0 =A0+1016, +1030, +1043, +1057, +1071, /* 100-109 */
> =A0 =A0 =A0 =A0+1085, +1098, +1112, +1126, +1140,
> =A0 =A0 =A0 =A0+1153, +1167, +1181, +1194, +1208, /* 110-119 */
> =A0 =A0 =A0 =A0+1222, +1235, +1249, +1250, +1250,
> =A0 =A0 =A0 =A0+1250, +1250, +1250, +1250, /* 120-128 */
> =A0 =A0};
>
> =A0 =A0temp =3D omap_ctrl_readl(OMAP343X_CONTROL_TEMP_SENSOR);
>
> =A0 =A0temp_val =3D (temp_table[temp&0x7f] + temp_table[(temp&0x7f)+1=
]) / 2;
> =A0 =A0sprintf(temp_buf, "%d.%1d (%02x)", temp_val/10, ((unsigned
> int)temp_val)%10, temp);
> }
>
> static ssize_t
> omap3logic_show_temp(struct class *class, char *buf)
> {
> =A0 =A0ssize_t retval;
> =A0 =A0char temp[128];
>
> =A0 =A0omap3logic_fetch_temp(temp);
> =A0 =A0retval =3D sprintf(buf, "%s\n", temp);
> =A0 =A0return retval;
> }
>
> static struct class_attribute temp_attr =3D
> =A0 =A0__ATTR(temp, S_IRUGO, omap3logic_show_temp, NULL);
>
> static struct class *omap3logic_temp_class;
>
> void omap3logic_temp_init(void)
> {
> =A0 =A0int rc;
>
> =A0 =A0omap3logic_temp_class =3D class_create(THIS_MODULE, "temp");
> =A0 =A0if (IS_ERR(omap3logic_temp_class)) {
> =A0 =A0 =A0 =A0printk(KERN_ERR "%s: couldn't create temp class\n", __=
=46UNCTION__);
> =A0 =A0 =A0 =A0return;
> =A0 =A0}
> =A0 =A0rc =3D class_create_file(omap3logic_temp_class, &temp_attr);
> =A0 =A0if (unlikely(rc)) {
> =A0 =A0 =A0 =A0printk(KERN_ERR "%s: couldn't create temp class file\n=
",
> __FUNCTION__);
> =A0 =A0 =A0 =A0return;
> =A0 =A0}
>
> =A0 =A0/* Set CONTCONV and SOC to start continuous temperature measur=
ements */
> =A0 =A0omap_ctrl_writel(0x300, OMAP343X_CONTROL_TEMP_SENSOR);
> }
>
> But when I read the register back, I see only a fixed temperature val=
ue,
> even if I fire up some video demos to crank up the load. =A0If I rebo=
ot I'll
> see the temperature jump up, but then it stays constant whether I
> increase/decrease the CPU load.
>
> Any ideas why this isn't working?
>
> Thanks in advance!
>
> --
> Peter Barada
> peterb@logicpd.com
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
