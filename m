From: Colin FoeParker <colin.foeparker-L+YfUVVR8+RBDgjK7y7TUQ@public.gmane.org>
Subject: RE: [PATCH 2/4] rtc: OMAP: Add system pm_power_off to rtc driver
Date: Mon, 5 Nov 2012 11:39:26 -0600
Message-ID: <0520A3FE5EDCF24F88B3F1451CFC64AE059F92FA8F@edprex01>
References: <1352108549-9341-1-git-send-email-anilkumar@ti.com>
 <1352108549-9341-3-git-send-email-anilkumar@ti.com> <5097ECAD.9010101@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2390053880300757345=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <5097ECAD.9010101-l0cyMroinI0@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>, AnilKumar Ch <anilkumar-l0cyMroinI0@public.gmane.org>
Cc: "a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org" <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, "sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org" <rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--===============2390053880300757345==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_0520A3FE5EDCF24F88B3F1451CFC64AE059F92FA8Fedprex01_"

--_000_0520A3FE5EDCF24F88B3F1451CFC64AE059F92FA8Fedprex01_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Benoit,



"I don't know how it is connected at board level, but I'm not sure the bind=
ing is the proper one."



Here is a link to the Beaglebone schematic<http://beagleboard.org/static/be=
aglebone/latest/Docs/Hardware/BONE_SCH.pdf>.  The PMIC_PWR_EN net is the on=
e that you should be interested in following.



In the AM335x, this net is connected to the ALARM2 event in the RTC subsyst=
em.  If the ALARM2 event is triggered, and the PMIC_PWR_EN pin is configure=
d correctly, the pin is driven low.



In the TPS65217 series PMIC, the PWR_EN I/O can be used to put the entire c=
hip into a low power state.  This disables all the power rails in the PMIC =
with an exception of the rail that powers the RTC power domain.



So when the ALARM2 event occurs, the PWR_EN I/O is pulled low and the entir=
e system into a low power "off" state.



"It does not look super generic, and I'm wondering if we should not use ins=
tead some regulator binding to reflect the connection of the RTC to a regul=
ator.



But without the board / soc spec it is hard to tell :-("



This is a good point.  I know that there are other omap SOC RTC's that do n=
ot support the ALARM2 implementation.  That being said, I would argue that =
there is more of a RTC connection with the implementation than a regulator.



Anil will probably have greater insight into the pro's/con's of the impleme=
ntation.



-Colin





Colin Foe-Parker // Software Engineer II







Logic PD /// engineering design services

5 Clock Tower Place. Suite 400

Maynard, MA 01754

T // 978.243.2045



colin.foeparker-L+YfUVVR8+RBDgjK7y7TUQ@public.gmane.org

www.logicpd.com

/ / / / / / / / / / / / / / / / / / / / / / / / /

This message (including any attachments) contains confidential information =
intended for a specific individual and purpose, and is protected by law. If=
 you are not the intended recipient, you should delete this message and are=
 hereby notified that any disclosure, copying, distribution, or other use o=
f this message, or the taking of any action based on it, is strictly prohib=
ited.





-----Original Message-----
From: Benoit Cousson [mailto:b-cousson-l0cyMroinI0@public.gmane.org]
Sent: Monday, November 05, 2012 11:43 AM
To: AnilKumar Ch; Colin FoeParker
Cc: a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org; sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org; tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org; grant.li=
kely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org; rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org; rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org; lin=
ux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; devicetree-d=
iscuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Subject: Re: [PATCH 2/4] rtc: OMAP: Add system pm_power_off to rtc driver



Hi Anil / Colin,



On 11/05/2012 10:42 AM, AnilKumar Ch wrote:

> From: Colin Foe-Parker <colin.foeparker-L+YfUVVR8+RBDgjK7y7TUQ@public.gmane.org>

>

> Add system power off control to rtc driver which is the in-charge of

> controlling the BeagleBone system power. The power_off routine can be

> hooked up to "pm_power_off" system call.

>

> System power off sequence:-

> * Set PMIC STATUS_OFF when PMIC_POWER_EN is pulled low

> * Enable PMIC_POWER_EN in rtc module

> * Set rtc ALARM2 time

> * Enable ALARM2 interrupt

>

> Added while (1); after the above steps to make sure that no other

> process acquire cpu. Otherwise we might see an unexpected behaviour

> because we are shutting down all the power rails of SoC except RTC.

>

> Signed-off-by: Colin Foe-Parker <colin.foeparker-L+YfUVVR8+RBDgjK7y7TUQ@public.gmane.org<mailto:colin=
.foeparker-L+YfUVVR8+RBDgjK7y7TUQ@public.gmane.org>>

> [anilkumar-l0cyMroinI0@public.gmane.org: move poweroff additions to rtc driver]

> Signed-off-by: AnilKumar Ch <anilkumar-l0cyMroinI0@public.gmane.org<mailto:anilkumar-l0cyMroinI0@public.gmane.org>>

> ---

>  Documentation/devicetree/bindings/rtc/rtc-omap.txt |    5 ++

>  drivers/rtc/rtc-omap.c                             |   79 ++++++++++++++=
+++++-

>  2 files changed, 83 insertions(+), 1 deletion(-)

>

> diff --git a/Documentation/devicetree/bindings/rtc/rtc-omap.txt

> b/Documentation/devicetree/bindings/rtc/rtc-omap.txt

> index b47aa41..8d9f4f9 100644

> --- a/Documentation/devicetree/bindings/rtc/rtc-omap.txt

> +++ b/Documentation/devicetree/bindings/rtc/rtc-omap.txt

> @@ -6,6 +6,10 @@ Required properties:

>  - interrupts: rtc timer, alarm interrupts in order

>  - interrupt-parent: phandle for the interrupt controller

>

> +Optional properties:

> +- ti,system-power-controller: Telling whether or not rtc is

> +controlling

> +  the system power.



I don't know how it is connected at board level, but I'm not sure the bindi=
ng is the proper one.

It does not look super generic, and I'm wondering if we should not use inst=
ead some regulator binding to reflect the connection of the RTC to a regula=
tor.



But without the board / soc spec it is hard to tell :-(



Regards,

Benoit





> +

>  Example:

>

>  rtc@1c23000 {

> @@ -14,4 +18,5 @@ rtc@1c23000 {

>             interrupts =3D <19

>                                   19>;

>             interrupt-parent =3D <&intc>;

> +          ti,system-power-controller;

>  };

> diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c index

> 6009714..2d90170 100644

> --- a/drivers/rtc/rtc-omap.c

> +++ b/drivers/rtc/rtc-omap.c

> @@ -72,6 +72,14 @@

>  #define OMAP_RTC_KICK0_REG                         0x6c

>  #define OMAP_RTC_KICK1_REG                         0x70

>

> +#define OMAP_RTC_ALARM2_SECONDS_REG            0x80

> +#define OMAP_RTC_ALARM2_MINUTES_REG            0x84

> +#define OMAP_RTC_ALARM2_HOURS_REG 0x88

> +#define OMAP_RTC_ALARM2_DAYS_REG     0x8c

> +#define OMAP_RTC_ALARM2_MONTHS_REG             0x90

> +#define OMAP_RTC_ALARM2_YEARS_REG   0x94

> +#define OMAP_RTC_PMIC_REG                        0x98

> +

>  /* OMAP_RTC_CTRL_REG bit fields: */

>  #define OMAP_RTC_CTRL_SPLIT                         (1<<7)

>  #define OMAP_RTC_CTRL_DISABLE                   (1<<6)

> @@ -93,15 +101,24 @@

>  #define OMAP_RTC_STATUS_BUSY            (1<<0)

>

>  /* OMAP_RTC_INTERRUPTS_REG bit fields: */

> +#define OMAP_RTC_INTERRUPTS_IT_ALARM2   (1<<4)

>  #define OMAP_RTC_INTERRUPTS_IT_ALARM    (1<<3)

>  #define OMAP_RTC_INTERRUPTS_IT_TIMER    (1<<2)

>

> +/* OMAP_RTC_PMIC_REG bit fields: */

> +#define OMAP_RTC_PMIC_POWER_EN_EN       (1<<16)

> +

>  /* OMAP_RTC_KICKER values */

>  #define           KICK0_VALUE                                    0x83e70=
b13

>  #define           KICK1_VALUE                                    0x95a4f=
1e0

>

>  #define           OMAP_RTC_HAS_KICKER                            0x1

>

> +#define SHUTDOWN_TIME_SEC                         2

> +#define SECS_IN_MIN                                            60

> +#define WAIT_AFTER                                              (SECS_IN=
_MIN - SHUTDOWN_TIME_SEC)

> +#define WAIT_TIME_MS                                       (SHUTDOWN_TIM=
E_SEC * 1000)

> +

>  static void __iomem  *rtc_base;

>

>  #define rtc_read(addr)                            readb(rtc_base + (addr=
))

> @@ -290,6 +307,58 @@ static int omap_rtc_set_alarm(struct device *dev, st=
ruct rtc_wkalrm *alm)

>             return 0;

>  }

>

> +/*

> + * rtc_power_off: Set the pmic power off sequence. The RTC generates

> + * pmic_pwr_enable control, which can be used to control an external

> + * PMIC.

> + */

> +static void rtc_power_off(void)

> +{

> +          u32 val;

> +          struct rtc_time tm;

> +          spinlock_t lock;

> +          unsigned long flags;

> +

> +          spin_lock_init(&lock);

> +

> +          /* Set PMIC power enable */

> +          val =3D readl(rtc_base + OMAP_RTC_PMIC_REG);

> +          writel(val | OMAP_RTC_PMIC_POWER_EN_EN, rtc_base +

> +OMAP_RTC_PMIC_REG);

> +

> +          /* Wait few seconds instead of rollover */

> +          do {

> +                          omap_rtc_read_time(NULL, &tm);

> +                          if (WAIT_AFTER <=3D tm.tm_sec)

> +                                          mdelay(WAIT_TIME_MS);

> +          } while (WAIT_AFTER <=3D tm.tm_sec);

> +

> +          /* Add shutdown time to the current value */

> +          tm.tm_sec +=3D SHUTDOWN_TIME_SEC;

> +

> +          if (tm2bcd(&tm) < 0)

> +                          return;

> +

> +          pr_info("System will go to power_off state in approx. %d secs\=
n",

> +                                          SHUTDOWN_TIME_SEC);

> +

> +          /* Set the ALARM2 time */

> +          rtc_write(tm.tm_sec, OMAP_RTC_ALARM2_SECONDS_REG);

> +          rtc_write(tm.tm_min, OMAP_RTC_ALARM2_MINUTES_REG);

> +          rtc_write(tm.tm_hour, OMAP_RTC_ALARM2_HOURS_REG);

> +          rtc_write(tm.tm_mday, OMAP_RTC_ALARM2_DAYS_REG);

> +          rtc_write(tm.tm_mon, OMAP_RTC_ALARM2_MONTHS_REG);

> +          rtc_write(tm.tm_year, OMAP_RTC_ALARM2_YEARS_REG);

> +

> +          /* Enable alarm2 interrupt */

> +          val =3D readl(rtc_base + OMAP_RTC_INTERRUPTS_REG);

> +          writel(val | OMAP_RTC_INTERRUPTS_IT_ALARM2,

> +                                                          rtc_base + OMA=
P_RTC_INTERRUPTS_REG);

> +

> +          /* Do not allow to execute any other task */

> +          spin_lock_irqsave(&lock, flags);

> +          while (1);

> +}

> +

>  static struct rtc_class_ops omap_rtc_ops =3D {

>             .read_time         =3D omap_rtc_read_time,

>             .set_time            =3D omap_rtc_set_time,

> @@ -327,12 +396,16 @@ static int __init omap_rtc_probe(struct platform_de=
vice *pdev)

>             struct resource                 *res, *mem;

>             struct rtc_device              *rtc;

>             u8                                           reg, new_ctrl;

> +          bool                                       pm_off =3D false;

>             const struct platform_device_id *id_entry;

>             const struct of_device_id *of_id;

>

>             of_id =3D of_match_device(omap_rtc_of_match, &pdev->dev);

> -           if (of_id)

> +          if (of_id) {

>                             pdev->id_entry =3D of_id->data;

> +                          pm_off =3D of_property_read_bool(pdev->dev.of_=
node,

> +                                                                        =
  "ti,system-power-controller");

> +          }

>

>             omap_rtc_timer =3D platform_get_irq(pdev, 0);

>             if (omap_rtc_timer <=3D 0) {

> @@ -385,6 +458,10 @@ static int __init omap_rtc_probe(struct platform_dev=
ice *pdev)

>             platform_set_drvdata(pdev, rtc);

>             dev_set_drvdata(&rtc->dev, mem);

>

> +          /* RTC power off */

> +          if (pm_off && !pm_power_off)

> +                          pm_power_off =3D rtc_power_off;

> +

>             /* clear pending irqs, and set 1/second periodic,

>              * which we'll use instead of update irqs

>              */

>



--_000_0520A3FE5EDCF24F88B3F1451CFC64AE059F92FA8Fedprex01_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40"><head><meta http-equiv=3DContent-Type content=
=3D"text/html; charset=3Dus-ascii"><meta name=3DGenerator content=3D"Micros=
oft Word 14 (filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{mso-style-priority:99;
	mso-style-link:"Plain Text Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
p.MsoAcetate, li.MsoAcetate, div.MsoAcetate
	{mso-style-priority:99;
	mso-style-link:"Balloon Text Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:8.0pt;
	font-family:"Tahoma","sans-serif";}
span.PlainTextChar
	{mso-style-name:"Plain Text Char";
	mso-style-priority:99;
	mso-style-link:"Plain Text";
	font-family:"Calibri","sans-serif";}
span.BalloonTextChar
	{mso-style-name:"Balloon Text Char";
	mso-style-priority:99;
	mso-style-link:"Balloon Text";
	font-family:"Tahoma","sans-serif";}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri","sans-serif";}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]--></head><body lang=3DEN-US link=3Dblue vli=
nk=3Dpurple><div class=3DWordSection1><p class=3DMsoPlainText>Hi Benoit,<o:=
p></o:p></p><p class=3DMsoPlainText><b><i><o:p>&nbsp;</o:p></i></b></p><p c=
lass=3DMsoPlainText><b><i>&#8220;I don't know how it is connected at board =
level, but I'm not sure the binding is the proper one.&#8221;<o:p></o:p></i=
></b></p><p class=3DMsoPlainText><o:p>&nbsp;</o:p></p><p class=3DMsoPlainTe=
xt>Here is a link to the <a href=3D"http://beagleboard.org/static/beaglebon=
e/latest/Docs/Hardware/BONE_SCH.pdf">Beaglebone schematic</a>.&nbsp; The PM=
IC_PWR_EN net is the one that you should be interested in following.<o:p></=
o:p></p><p class=3DMsoPlainText><o:p>&nbsp;</o:p></p><p class=3DMsoPlainTex=
t>In the AM335x, this net is connected to the ALARM2 event in the RTC subsy=
stem. &nbsp;If the ALARM2 event is triggered, and the PMIC_PWR_EN pin is co=
nfigured correctly, the pin is driven low.<o:p></o:p></p><p class=3DMsoPlai=
nText><o:p>&nbsp;</o:p></p><p class=3DMsoPlainText>In the TPS65217 series P=
MIC, the PWR_EN I/O can be used to put the entire chip into a low power sta=
te.&nbsp; This disables all the power rails in the PMIC with an exception o=
f the rail that powers the RTC power domain.<o:p></o:p></p><p class=3DMsoPl=
ainText><o:p>&nbsp;</o:p></p><p class=3DMsoPlainText>So when the ALARM2 eve=
nt occurs, the PWR_EN I/O is pulled low and the entire system into a low po=
wer &#8220;off&#8221; state.<o:p></o:p></p><p class=3DMsoPlainText><o:p>&nb=
sp;</o:p></p><p class=3DMsoPlainText><b><i>&#8220;It does not look super ge=
neric, and I'm wondering if we should not use instead some regulator bindin=
g to reflect the connection of the RTC to a regulator.<o:p></o:p></i></b></=
p><p class=3DMsoPlainText><b><i><o:p>&nbsp;</o:p></i></b></p><p class=3DMso=
PlainText><b><i>But without the board / soc spec it is hard to tell :-(&#82=
20;<o:p></o:p></i></b></p><p class=3DMsoPlainText><o:p>&nbsp;</o:p></p><p c=
lass=3DMsoPlainText>This is a good point.&nbsp; I know that there are other=
 omap SOC RTC&#8217;s that do not support the ALARM2 implementation.&nbsp; =
That being said, I would argue that there is more of a RTC connection with =
the implementation than a regulator.<o:p></o:p></p><p class=3DMsoPlainText>=
<o:p>&nbsp;</o:p></p><p class=3DMsoPlainText>Anil will probably have greate=
r insight into the pro&#8217;s/con&#8217;s of the implementation.<o:p></o:p=
></p><p class=3DMsoPlainText><o:p>&nbsp;</o:p></p><p class=3DMsoPlainText>-=
Colin<o:p></o:p></p><p class=3DMsoPlainText><o:p>&nbsp;</o:p></p><p class=
=3DMsoPlainText><o:p>&nbsp;</o:p></p><p class=3DMsoPlainText>Colin Foe-Park=
er&nbsp;//&nbsp;Software Engineer II<o:p></o:p></p><p class=3DMsoPlainText>=
<o:p>&nbsp;</o:p></p><p class=3DMsoPlainText>&nbsp;<o:p></o:p></p><p class=
=3DMsoPlainText><o:p>&nbsp;</o:p></p><p class=3DMsoPlainText>Logic PD /// e=
ngineering design services<o:p></o:p></p><p class=3DMsoPlainText>5 Clock To=
wer Place. Suite 400<o:p></o:p></p><p class=3DMsoPlainText>Maynard, MA 0175=
4<o:p></o:p></p><p class=3DMsoPlainText>T // 978.243.2045<o:p></o:p></p><p =
class=3DMsoPlainText>&nbsp;<o:p></o:p></p><p class=3DMsoPlainText>colin.foe=
parker-L+YfUVVR8+RBDgjK7y7TUQ@public.gmane.org<o:p></o:p></p><p class=3DMsoPlainText>www.logicpd.com<o:=
p></o:p></p><p class=3DMsoPlainText>/ / / / / / / / / / / / / / / / / / / /=
 / / / / /<o:p></o:p></p><p class=3DMsoPlainText>This message (including an=
y attachments) contains confidential information intended for a specific in=
dividual and purpose, and is protected by law. If you are not the intended =
recipient, you should delete this message and are hereby notified that any =
disclosure, copying, distribution, or other use of this message, or the tak=
ing of any action based on it, is strictly prohibited.<o:p></o:p></p><p cla=
ss=3DMsoPlainText><o:p>&nbsp;</o:p></p><p class=3DMsoPlainText><o:p>&nbsp;<=
/o:p></p><p class=3DMsoPlainText>-----Original Message-----<br>From: Benoit=
 Cousson [mailto:b-cousson-l0cyMroinI0@public.gmane.org] <br>Sent: Monday, November 05, 2012 11:4=
3 AM<br>To: AnilKumar Ch; Colin FoeParker<br>Cc: a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org; same=
o@linux.intel.com; tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org; grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org; rob.herring=
@calxeda.com; rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org; linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux=
-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org<br>Sub=
ject: Re: [PATCH 2/4] rtc: OMAP: Add system pm_power_off to rtc driver</p><=
p class=3DMsoPlainText><o:p>&nbsp;</o:p></p><p class=3DMsoPlainText>Hi Anil=
 / Colin,<o:p></o:p></p><p class=3DMsoPlainText><o:p>&nbsp;</o:p></p><p cla=
ss=3DMsoPlainText>On 11/05/2012 10:42 AM, AnilKumar Ch wrote:<o:p></o:p></p=
><p class=3DMsoPlainText>&gt; From: Colin Foe-Parker &lt;colin.foeparker@lo=
gicpd.com&gt;<o:p></o:p></p><p class=3DMsoPlainText>&gt; <o:p></o:p></p><p =
class=3DMsoPlainText>&gt; Add system power off control to rtc driver which =
is the in-charge of <o:p></o:p></p><p class=3DMsoPlainText>&gt; controlling=
 the BeagleBone system power. The power_off routine can be <o:p></o:p></p><=
p class=3DMsoPlainText>&gt; hooked up to &quot;pm_power_off&quot; system ca=
ll.<o:p></o:p></p><p class=3DMsoPlainText>&gt; <o:p></o:p></p><p class=3DMs=
oPlainText>&gt; System power off sequence:-<o:p></o:p></p><p class=3DMsoPla=
inText>&gt; * Set PMIC STATUS_OFF when PMIC_POWER_EN is pulled low<o:p></o:=
p></p><p class=3DMsoPlainText>&gt; * Enable PMIC_POWER_EN in rtc module<o:p=
></o:p></p><p class=3DMsoPlainText>&gt; * Set rtc ALARM2 time<o:p></o:p></p=
><p class=3DMsoPlainText>&gt; * Enable ALARM2 interrupt<o:p></o:p></p><p cl=
ass=3DMsoPlainText>&gt; <o:p></o:p></p><p class=3DMsoPlainText>&gt; Added w=
hile (1); after the above steps to make sure that no other <o:p></o:p></p><=
p class=3DMsoPlainText>&gt; process acquire cpu. Otherwise we might see an =
unexpected behaviour <o:p></o:p></p><p class=3DMsoPlainText>&gt; because we=
 are shutting down all the power rails of SoC except RTC.<o:p></o:p></p><p =
class=3DMsoPlainText>&gt; <o:p></o:p></p><p class=3DMsoPlainText>&gt; Signe=
d-off-by: Colin Foe-Parker &lt;<a href=3D"mailto:colin.foeparker-L+YfUVVR8+SIwRZHo2/mJg@public.gmane.org=
m"><span style=3D'color:windowtext;text-decoration:none'>colin.foeparker@lo=
gicpd.com</span></a>&gt;<o:p></o:p></p><p class=3DMsoPlainText>&gt; [anilku=
mar-l0cyMroinI0@public.gmane.org: move poweroff additions to rtc driver]<o:p></o:p></p><p class=
=3DMsoPlainText>&gt; Signed-off-by: AnilKumar Ch &lt;<a href=3D"mailto:anil=
kumar-l0cyMroinI0@public.gmane.org"><span style=3D'color:windowtext;text-decoration:none'>anilkum=
ar-l0cyMroinI0@public.gmane.org</span></a>&gt;<o:p></o:p></p><p class=3DMsoPlainText>&gt; ---<o:p=
></o:p></p><p class=3DMsoPlainText>&gt;&nbsp; Documentation/devicetree/bind=
ings/rtc/rtc-omap.txt |&nbsp;&nbsp;&nbsp; 5 ++<o:p></o:p></p><p class=3DMso=
PlainText>&gt;&nbsp; drivers/rtc/rtc-omap.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;=
 79 +++++++++++++++++++-<o:p></o:p></p><p class=3DMsoPlainText>&gt;&nbsp; 2=
 files changed, 83 insertions(+), 1 deletion(-)<o:p></o:p></p><p class=3DMs=
oPlainText>&gt; <o:p></o:p></p><p class=3DMsoPlainText>&gt; diff --git a/Do=
cumentation/devicetree/bindings/rtc/rtc-omap.txt <o:p></o:p></p><p class=3D=
MsoPlainText>&gt; b/Documentation/devicetree/bindings/rtc/rtc-omap.txt<o:p>=
</o:p></p><p class=3DMsoPlainText>&gt; index b47aa41..8d9f4f9 100644<o:p></=
o:p></p><p class=3DMsoPlainText>&gt; --- a/Documentation/devicetree/binding=
s/rtc/rtc-omap.txt<o:p></o:p></p><p class=3DMsoPlainText>&gt; +++ b/Documen=
tation/devicetree/bindings/rtc/rtc-omap.txt<o:p></o:p></p><p class=3DMsoPla=
inText>&gt; @@ -6,6 +6,10 @@ Required properties:<o:p></o:p></p><p class=3D=
MsoPlainText>&gt;&nbsp; - interrupts: rtc timer, alarm interrupts in order<=
o:p></o:p></p><p class=3DMsoPlainText>&gt;&nbsp; - interrupt-parent: phandl=
e for the interrupt controller<o:p></o:p></p><p class=3DMsoPlainText>&gt;&n=
bsp; <o:p></o:p></p><p class=3DMsoPlainText>&gt; +Optional properties:<o:p>=
</o:p></p><p class=3DMsoPlainText>&gt; +- ti,system-power-controller: Telli=
ng whether or not rtc is <o:p></o:p></p><p class=3DMsoPlainText>&gt; +contr=
olling<o:p></o:p></p><p class=3DMsoPlainText>&gt; +&nbsp; the system power.=
<o:p></o:p></p><p class=3DMsoPlainText><o:p>&nbsp;</o:p></p><p class=3DMsoP=
lainText>I don't know how it is connected at board level, but I'm not sure =
the binding is the proper one.<o:p></o:p></p><p class=3DMsoPlainText>It doe=
s not look super generic, and I'm wondering if we should not use instead so=
me regulator binding to reflect the connection of the RTC to a regulator.<o=
:p></o:p></p><p class=3DMsoPlainText><o:p>&nbsp;</o:p></p><p class=3DMsoPla=
inText>But without the board / soc spec it is hard to tell :-(<o:p></o:p></=
p><p class=3DMsoPlainText><o:p>&nbsp;</o:p></p><p class=3DMsoPlainText>Rega=
rds,<o:p></o:p></p><p class=3DMsoPlainText>Benoit<o:p></o:p></p><p class=3D=
MsoPlainText><o:p>&nbsp;</o:p></p><p class=3DMsoPlainText><o:p>&nbsp;</o:p>=
</p><p class=3DMsoPlainText>&gt; +<o:p></o:p></p><p class=3DMsoPlainText>&g=
t;&nbsp; Example:<o:p></o:p></p><p class=3DMsoPlainText>&gt;&nbsp; <o:p></o=
:p></p><p class=3DMsoPlainText>&gt;&nbsp; rtc@1c23000 {<o:p></o:p></p><p cl=
ass=3DMsoPlainText>&gt; @@ -14,4 +18,5 @@ rtc@1c23000 {<o:p></o:p></p><p cl=
ass=3DMsoPlainText>&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; interrupts =3D &lt;19<o:p></o:p></p><p class=3DMsoPlainText=
>&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;19&gt;;<o:p></o:p></=
p><p class=3DMsoPlainText>&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; interrupt-parent =3D &lt;&amp;intc&gt;;<o:p></o:p></=
p><p class=3DMsoPlainText>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; ti,system-power-controller;<o:p></o:p></p><p class=3DMsoPlainTe=
xt>&gt;&nbsp; };<o:p></o:p></p><p class=3DMsoPlainText>&gt; diff --git a/dr=
ivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c index <o:p></o:p></p><p class=
=3DMsoPlainText>&gt; 6009714..2d90170 100644<o:p></o:p></p><p class=3DMsoPl=
ainText>&gt; --- a/drivers/rtc/rtc-omap.c<o:p></o:p></p><p class=3DMsoPlain=
Text>&gt; +++ b/drivers/rtc/rtc-omap.c<o:p></o:p></p><p class=3DMsoPlainTex=
t>&gt; @@ -72,6 +72,14 @@<o:p></o:p></p><p class=3DMsoPlainText>&gt;&nbsp; =
#define OMAP_RTC_KICK0_REG&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; 0x6c<o:p></o:p></p><p class=3DMsoPlainText>&gt;&nbsp; =
#define OMAP_RTC_KICK1_REG&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; 0x70<o:p></o:p></p><p class=3DMsoPlainText>&gt;&nbsp; =
<o:p></o:p></p><p class=3DMsoPlainText>&gt; +#define OMAP_RTC_ALARM2_SECOND=
S_REG&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8=
0<o:p></o:p></p><p class=3DMsoPlainText>&gt; +#define OMAP_RTC_ALARM2_MINUT=
ES_REG&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x=
84<o:p></o:p></p><p class=3DMsoPlainText>&gt; +#define OMAP_RTC_ALARM2_HOUR=
S_REG 0x88<o:p></o:p></p><p class=3DMsoPlainText>&gt; +#define OMAP_RTC_ALA=
RM2_DAYS_REG&nbsp;&nbsp;&nbsp;&nbsp; 0x8c<o:p></o:p></p><p class=3DMsoPlain=
Text>&gt; +#define OMAP_RTC_ALARM2_MONTHS_REG&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x90<o:p></o:p></p><p class=3DMs=
oPlainText>&gt; +#define OMAP_RTC_ALARM2_YEARS_REG&nbsp;&nbsp; 0x94<o:p></o=
:p></p><p class=3DMsoPlainText>&gt; +#define OMAP_RTC_PMIC_REG&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x98<o:p></o:p></p><p cl=
ass=3DMsoPlainText>&gt; +<o:p></o:p></p><p class=3DMsoPlainText>&gt;&nbsp; =
/* OMAP_RTC_CTRL_REG bit fields: */<o:p></o:p></p><p class=3DMsoPlainText>&=
gt;&nbsp; #define OMAP_RTC_CTRL_SPLIT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (1&lt;&lt;7)<o:p></o:p></p><p class=3DMsoPl=
ainText>&gt;&nbsp; #define OMAP_RTC_CTRL_DISABLE&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; (1&lt;&lt;6)<o:p></o:p></p><p class=3DMsoPlainText>&gt; @@ -93,15 +1=
01,24 @@<o:p></o:p></p><p class=3DMsoPlainText>&gt;&nbsp; #define OMAP_RTC_=
STATUS_BUSY&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; (1&lt;&lt;0)<o:p></o:p></p><p class=3DMsoPlainText>&gt;&nbsp; <o:p></o:p=
></p><p class=3DMsoPlainText>&gt;&nbsp; /* OMAP_RTC_INTERRUPTS_REG bit fiel=
ds: */<o:p></o:p></p><p class=3DMsoPlainText>&gt; +#define OMAP_RTC_INTERRU=
PTS_IT_ALARM2&nbsp;&nbsp; (1&lt;&lt;4)<o:p></o:p></p><p class=3DMsoPlainTex=
t>&gt;&nbsp; #define OMAP_RTC_INTERRUPTS_IT_ALARM&nbsp;&nbsp;&nbsp; (1&lt;&=
lt;3)<o:p></o:p></p><p class=3DMsoPlainText>&gt;&nbsp; #define OMAP_RTC_INT=
ERRUPTS_IT_TIMER&nbsp;&nbsp;&nbsp; (1&lt;&lt;2)<o:p></o:p></p><p class=3DMs=
oPlainText>&gt;&nbsp; <o:p></o:p></p><p class=3DMsoPlainText>&gt; +/* OMAP_=
RTC_PMIC_REG bit fields: */<o:p></o:p></p><p class=3DMsoPlainText>&gt; +#de=
fine OMAP_RTC_PMIC_POWER_EN_EN&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;(1&lt;&l=
t;16)<o:p></o:p></p><p class=3DMsoPlainText>&gt; +<o:p></o:p></p><p class=
=3DMsoPlainText>&gt;&nbsp; /* OMAP_RTC_KICKER values */<o:p></o:p></p><p cl=
ass=3DMsoPlainText>&gt;&nbsp; #define&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; KICK0_VALUE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 0x83e70b13<o:p></o:p></p><p class=3DMsoPlainText>&gt;&n=
bsp; #define&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KI=
CK1_VALUE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x95a=
4f1e0<o:p></o:p></p><p class=3DMsoPlainText>&gt;&nbsp; <o:p></o:p></p><p cl=
ass=3DMsoPlainText>&gt;&nbsp; #define&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; OMAP_RTC_HAS_KICKER&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1<o:p></o:p></p><p=
 class=3DMsoPlainText>&gt;&nbsp; <o:p></o:p></p><p class=3DMsoPlainText>&gt=
; +#define SHUTDOWN_TIME_SEC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; 2<o:p></o:p></p><p class=3DMsoPlainText>&gt; +#defin=
e SECS_IN_MIN&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 60<o:p></o:p></p><p class=3D=
MsoPlainText>&gt; +#define WAIT_AFTER&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; (SECS_IN_MIN - SHUTDOWN_TIME_SEC)<o:p></o:p></p><p class=3DMsoPlain=
Text>&gt; +#define WAIT_TIME_MS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (SHUTDOWN_TIME_SEC * 1000)<o:p></o:p></p=
><p class=3DMsoPlainText>&gt; +<o:p></o:p></p><p class=3DMsoPlainText>&gt;&=
nbsp; static void __iomem&nbsp; *rtc_base;<o:p></o:p></p><p class=3DMsoPlai=
nText>&gt;&nbsp; <o:p></o:p></p><p class=3DMsoPlainText>&gt;&nbsp; #define =
rtc_read(addr)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; readb(rtc_base + (addr))<o:p></o:p></p><p class=
=3DMsoPlainText>&gt; @@ -290,6 +307,58 @@ static int omap_rtc_set_alarm(str=
uct device *dev, struct rtc_wkalrm *alm)<o:p></o:p></p><p class=3DMsoPlainT=
ext>&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 return 0;<o:p></o:p></p><p class=3DMsoPlainText>&gt;&nbsp; }<o:p></o:p></p=
><p class=3DMsoPlainText>&gt;&nbsp; <o:p></o:p></p><p class=3DMsoPlainText>=
&gt; +/*<o:p></o:p></p><p class=3DMsoPlainText>&gt; + * rtc_power_off: Set =
the pmic power off sequence. The RTC generates<o:p></o:p></p><p class=3DMso=
PlainText>&gt; + * pmic_pwr_enable control, which can be used to control an=
 external<o:p></o:p></p><p class=3DMsoPlainText>&gt; + * PMIC.<o:p></o:p></=
p><p class=3DMsoPlainText>&gt; + */<o:p></o:p></p><p class=3DMsoPlainText>&=
gt; +static void rtc_power_off(void)<o:p></o:p></p><p class=3DMsoPlainText>=
&gt; +{<o:p></o:p></p><p class=3DMsoPlainText>&gt; +&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 val;<o:p></o:p></p><p class=3DMsoPlainT=
ext>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rtc=
_time tm;<o:p></o:p></p><p class=3DMsoPlainText>&gt; +&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spinlock_t lock;<o:p></o:p></p><p class=
=3DMsoPlainText>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; unsigned long flags;<o:p></o:p></p><p class=3DMsoPlainText>&gt; +<o:p></o=
:p></p><p class=3DMsoPlainText>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; spin_lock_init(&amp;lock);<o:p></o:p></p><p class=3DMsoPla=
inText>&gt; +<o:p></o:p></p><p class=3DMsoPlainText>&gt; +&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Set PMIC power enable */<o:p></o:p=
></p><p class=3DMsoPlainText>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; val =3D readl(rtc_base + OMAP_RTC_PMIC_REG);<o:p></o:p></p><=
p class=3DMsoPlainText>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; writel(val | OMAP_RTC_PMIC_POWER_EN_EN, rtc_base + <o:p></o:p></p>=
<p class=3DMsoPlainText>&gt; +OMAP_RTC_PMIC_REG);<o:p></o:p></p><p class=3D=
MsoPlainText>&gt; +<o:p></o:p></p><p class=3DMsoPlainText>&gt; +&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Wait few seconds instead of =
rollover */<o:p></o:p></p><p class=3DMsoPlainText>&gt; +&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; do {<o:p></o:p></p><p class=3DMsoPlainT=
ext>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; omap_rtc_read_time(NULL, &amp;tm);<o:p></o:p></p><p class=3DMsoP=
lainText>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (WAIT_AFTER &lt;=3D tm.tm_sec)<o:p></o:p></p><p class=3D=
MsoPlainText>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mdelay(WAIT_TIME_MS);<o:p></o:p></=
p><p class=3DMsoPlainText>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; } while (WAIT_AFTER &lt;=3D tm.tm_sec);<o:p></o:p></p><p class=
=3DMsoPlainText>&gt; +<o:p></o:p></p><p class=3DMsoPlainText>&gt; +&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Add shutdown time to the =
current value */<o:p></o:p></p><p class=3DMsoPlainText>&gt; +&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tm.tm_sec +=3D SHUTDOWN_TIME_SEC;<=
o:p></o:p></p><p class=3DMsoPlainText>&gt; +<o:p></o:p></p><p class=3DMsoPl=
ainText>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (tm=
2bcd(&amp;tm) &lt; 0)<o:p></o:p></p><p class=3DMsoPlainText>&gt; +&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<=
o:p></o:p></p><p class=3DMsoPlainText>&gt; +<o:p></o:p></p><p class=3DMsoPl=
ainText>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_inf=
o(&quot;System will go to power_off state in approx. %d secs\n&quot;,<o:p><=
/o:p></p><p class=3DMsoPlainText>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SHUTDOWN_TIME_=
SEC);<o:p></o:p></p><p class=3DMsoPlainText>&gt; +<o:p></o:p></p><p class=
=3DMsoPlainText>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; /* Set the ALARM2 time */<o:p></o:p></p><p class=3DMsoPlainText>&gt; +&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rtc_write(tm.tm_sec, OM=
AP_RTC_ALARM2_SECONDS_REG);<o:p></o:p></p><p class=3DMsoPlainText>&gt; +&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rtc_write(tm.tm_min, OM=
AP_RTC_ALARM2_MINUTES_REG);<o:p></o:p></p><p class=3DMsoPlainText>&gt; +&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rtc_write(tm.tm_hour, O=
MAP_RTC_ALARM2_HOURS_REG);<o:p></o:p></p><p class=3DMsoPlainText>&gt; +&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rtc_write(tm.tm_mday, OM=
AP_RTC_ALARM2_DAYS_REG);<o:p></o:p></p><p class=3DMsoPlainText>&gt; +&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rtc_write(tm.tm_mon, OMAP_=
RTC_ALARM2_MONTHS_REG);<o:p></o:p></p><p class=3DMsoPlainText>&gt; +&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rtc_write(tm.tm_year, OMAP_=
RTC_ALARM2_YEARS_REG);<o:p></o:p></p><p class=3DMsoPlainText>&gt; +<o:p></o=
:p></p><p class=3DMsoPlainText>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; /* Enable alarm2 interrupt */<o:p></o:p></p><p class=3DMso=
PlainText>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val =
=3D readl(rtc_base + OMAP_RTC_INTERRUPTS_REG);<o:p></o:p></p><p class=3DMso=
PlainText>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; writ=
el(val | OMAP_RTC_INTERRUPTS_IT_ALARM2,<o:p></o:p></p><p class=3DMsoPlainTe=
xt>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rtc_base + OMAP_RTC_INT=
ERRUPTS_REG);<o:p></o:p></p><p class=3DMsoPlainText>&gt; +<o:p></o:p></p><p=
 class=3DMsoPlainText>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; /* Do not allow to execute any other task */<o:p></o:p></p><p class=
=3DMsoPlainText>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; spin_lock_irqsave(&amp;lock, flags);<o:p></o:p></p><p class=3DMsoPlainTex=
t>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (1);<o=
:p></o:p></p><p class=3DMsoPlainText>&gt; +}<o:p></o:p></p><p class=3DMsoPl=
ainText>&gt; +<o:p></o:p></p><p class=3DMsoPlainText>&gt;&nbsp; static stru=
ct rtc_class_ops omap_rtc_ops =3D {<o:p></o:p></p><p class=3DMsoPlainText>&=
gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .rea=
d_time&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D omap_rtc_read_ti=
me,<o:p></o:p></p><p class=3DMsoPlainText>&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_time&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D omap_rtc_set_time,<o:p></o:p></=
p><p class=3DMsoPlainText>&gt; @@ -327,12 +396,16 @@ static int __init omap=
_rtc_probe(struct platform_device *pdev)<o:p></o:p></p><p class=3DMsoPlainT=
ext>&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 struct resource&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *res, *mem;<o:p></o:p></p><p class=3D=
MsoPlainText>&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; struct rtc_device&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *rtc;<o:p></o:p></p><p class=3DMsoPlainText>=
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u8&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; reg, new_ctrl;<o:p></o:p></p><p class=3DMsoPlain=
Text>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p=
m_off =3D false;<o:p></o:p></p><p class=3DMsoPlainText>&gt;&nbsp; &nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct platform_d=
evice_id *id_entry;<o:p></o:p></p><p class=3DMsoPlainText>&gt;&nbsp; &nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct of_devi=
ce_id *of_id;<o:p></o:p></p><p class=3DMsoPlainText>&gt;&nbsp; <o:p></o:p><=
/p><p class=3DMsoPlainText>&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; of_id =3D of_match_device(omap_rtc_of_match, &amp;p=
dev-&gt;dev);<o:p></o:p></p><p class=3DMsoPlainText>&gt; -&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (of_id)<o:p></o:p></p><p cla=
ss=3DMsoPlainText>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (of_id) {<o:p></o:p></p><p class=3DMsoPlainText>&gt;&nbsp; &nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pd=
ev-&gt;id_entry =3D of_id-&gt;data;<o:p></o:p></p><p class=3DMsoPlainText>&=
gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; pm_off =3D of_property_read_bool(pdev-&gt;dev.of_node,<o:p></o:p></p>=
<p class=3DMsoPlainText>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; &quot;ti,system-power-controller&quot;);<o:p></o:p></p><=
p class=3DMsoPlainText>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; }<o:p></o:p></p><p class=3DMsoPlainText>&gt;&nbsp; <o:p></o:p></p>=
<p class=3DMsoPlainText>&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; omap_rtc_timer =3D platform_get_irq(pdev, 0);<o:p></o:=
p></p><p class=3DMsoPlainText>&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; if (omap_rtc_timer &lt;=3D 0) {<o:p></o:p></p><p=
 class=3DMsoPlainText>&gt; @@ -385,6 +458,10 @@ static int __init omap_rtc_=
probe(struct platform_device *pdev)<o:p></o:p></p><p class=3DMsoPlainText>&=
gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; plat=
form_set_drvdata(pdev, rtc);<o:p></o:p></p><p class=3DMsoPlainText>&gt;&nbs=
p; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_set_drv=
data(&amp;rtc-&gt;dev, mem);<o:p></o:p></p><p class=3DMsoPlainText>&gt;&nbs=
p; <o:p></o:p></p><p class=3DMsoPlainText>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; /* RTC power off */<o:p></o:p></p><p class=3DMs=
oPlainText>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(pm_off &amp;&amp; !pm_power_off)<o:p></o:p></p><p class=3DMsoPlainText>&gt=
; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; pm_power_off =3D rtc_power_off;<o:p></o:p></p><p class=3DMsoPlainText>&=
gt; +<o:p></o:p></p><p class=3DMsoPlainText>&gt;&nbsp; &nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* clear pending irqs, and set 1/s=
econd periodic,<o:p></o:p></p><p class=3DMsoPlainText>&gt;&nbsp; &nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;* which we'll use =
instead of update irqs<o:p></o:p></p><p class=3DMsoPlainText>&gt;&nbsp; &nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;*/<o:p></o:=
p></p><p class=3DMsoPlainText>&gt; <o:p></o:p></p><p class=3DMsoPlainText><=
o:p>&nbsp;</o:p></p></div></body></html>=

--_000_0520A3FE5EDCF24F88B3F1451CFC64AE059F92FA8Fedprex01_--

--===============2390053880300757345==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============2390053880300757345==--
