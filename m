From: "K, Mythri P" <mythripk@ti.com>
Subject: Re: [PATCH v2 5/5] OMAPDSS: HDMI: Add support to dump clocks through
Date: Fri, 23 Sep 2011 11:22:59 +0530
Message-ID: <CAP5A+B-Ahwfk4tu3OtvRpfejFbv_jVpiVmoNJW0cGTfiwkG7kA@mail.gmail.com>
References: <1316678866-17749-1-git-send-email-mythripk@ti.com>
 <1316678866-17749-2-git-send-email-mythripk@ti.com> <1316678866-17749-3-git-send-email-mythripk@ti.com>
 <1316678866-17749-4-git-send-email-mythripk@ti.com> <1316678866-17749-5-git-send-email-mythripk@ti.com>
 <1316678866-17749-6-git-send-email-mythripk@ti.com> <1316692870.2442.24.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:46041 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751325Ab1IWFxV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 23 Sep 2011 01:53:21 -0400
Received: by vchq10 with SMTP id q10so1385641vch.23
        for <linux-omap@vger.kernel.org>; Thu, 22 Sep 2011 22:53:19 -0700 (PDT)
In-Reply-To: <1316692870.2442.24.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org

Hi,

On Thu, Sep 22, 2011 at 5:31 PM, Tomi Valkeinen <tomi.valkeinen@ti.com>=
 wrote:
> On Thu, 2011-09-22 at 13:37 +0530, mythripk@ti.com wrote:
>> From: Mythri P K <mythripk@ti.com>
>>
>> Add support to dump the HDMI regm, regn, and other clock parameters.
>
> The subjects of this and previous patch seem to be still broken. And
> while at it, you could fix missing periods and misplaced spaces (like
> "foo ,bar") in the descriptions of this patch series.
>
Taken.
>> +void hdmi_dump_clocks(struct seq_file *s)
>> +{
>> + =A0 =A0 enum omap_dss_clk_source dispc_clk_src;
>> +
>> + =A0 =A0 dispc_clk_src =3D dss_get_dispc_clk_source();
>> +
>> + =A0 =A0 if (hdmi_runtime_get())
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> +
>> + =A0 =A0 seq_printf(s, "- HDMI PLL -\n");
>> +
>> + =A0 =A0 seq_printf(s, "regm\t%u\n", hdmi.ip_data.pll_data.regm);
>> +
>> + =A0 =A0 seq_printf(s, "regmf\t%u\n", hdmi.ip_data.pll_data.regmf);
>> +
>> + =A0 =A0 seq_printf(s, "dcofreq\t%u\n", hdmi.ip_data.pll_data.dcofr=
eq);
>> +
>> + =A0 =A0 seq_printf(s, "regsd\t%u\n", hdmi.ip_data.pll_data.regsd);
>
> Printing the dividers is fine, but I think we're usually more interes=
ted
> in the resulting clocks. So you should print also the clocks. Possibl=
y
> internal clocks (like Fint for DSI) also, but at least the output
> clocks. I believe for HDMI PLL they are CLKOUTLDO and CLKDCOLDO.
>
The clkoutldo would be the pixel clock which is a synthesis of these pa=
rameters,
I could print.
> Looking at the dividers also brings up two things not directly relate=
d
> to this patch:
>
> - What is dcofreq? Looking at the code, it tells if the pixel clock i=
s >
> 1000MHz. Why is such a field needed, can't the HDMI driver manage tha=
t
> itself? And if it's needed, why is it called dcofreq, the name doesn'=
t
> make much sense to me.
It is DCO frequency, It suggest the frequency selector range ,
HDMI_PLL_CONFIGURATION2 (3:1) has to be set accordingly by the driver
depending on whether the CLKOUTLDO is greater than or less than
1000Mhz, but anyways the decision is taken by the driver.
Also the name is as suggested by TRM .

>
> - We are doing HDMI PLL calculations in the omapdss drivers hdmi.c fi=
le.
> The PLL calculations are PLL specific, and thus should be in the
> specific HDMI implementation file, right?
>
>> + =A0 =A0 seq_printf(s, "DISPC clock source %s (%s)\t(%s)\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dss_get_generic_clk_source=
_name(dispc_clk_src),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dss_feat_get_clk_source_na=
me(dispc_clk_src),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dispc_clk_src =3D=3D OMAP_=
DSS_CLK_SRC_FCK ?
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "off" : "on");
>
> Why do you print DISPC clock source? How is that part of HDMI clock
> configuration?
Reason is to check whether the DISPC clock source is PRCM / DSI PLL,
Because DSI PLL might not be sufficient.
>
>> +
>> + =A0 =A0 seq_printf(s, "hdmi %s source rate =3D %lu\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hdmi.ip_data.pll_data.refs=
el =3D=3D HDMI_REFSEL_SYSCLK ?
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "sysclk" : "pclk/ref1/ref2=
",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_get_rate(hdmi.sys_clk)=
);
>
> Here I think it would be better to use the same format as the already
> existing outputs (DSI). And as the PLL source is base clock, it's mor=
e
> logical to print it first, like DSI does.
Sure can move it. I shall print sysclk and output clock frequency first=
=2E
>
> =A0Tomi
>
>
>
Thanks and regards,
Mythri.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
