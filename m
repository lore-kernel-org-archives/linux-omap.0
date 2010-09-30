From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH] OMAP4: Extend clock data.
Date: Thu, 30 Sep 2010 11:31:24 +0200
Message-ID: <4CA458EC.7050202@ti.com>
References: <1285833630-23044-1-git-send-email-thara@ti.com> <alpine.DEB.2.00.1009300247170.5439@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59145 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755750Ab0I3Jb2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 Sep 2010 05:31:28 -0400
In-Reply-To: <alpine.DEB.2.00.1009300247170.5439@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Gopinath, Thara" <thara@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>

Hi Thara,

Here is the full email...

On 9/30/2010 10:57 AM, Paul Walmsley wrote:
> Hello Thara,
>
> On Thu, 30 Sep 2010, Thara Gopinath wrote:
>
>> This patch extends the OMAP4 clock data to include
>> various x2 clock nodes as the clock framework
>> skips a *2 whie calculating the dpll locked frequency.
>>
>> Signed-off-by: Thara Gopinath<thara@ti.com>
>> Acked-by: Kevin Hilman<khilman@deeprootsystems.com>
>> ---
>> Currently the framework is extended to include x2 nodes
>> only for a few clocks critical for OMAP4 DVFS. This
>> exercise needs to be done for most of the other post divider
>> clocks as and when necessary.
>
> Beno=EEt and I have been discussing this - I think we should probably=
 fix
> this problem for all of the DPLLs and HSDIVIDERs in one patch.  I'll =
let
> Beno=EEt comment further, but I think the current plan will be to gen=
erate a
> CLKOUTX2 node after the DPLLs, and then to use that as the parent for
> the various HSDIVIDERs that use that X2 output.

Here is the way it should look for my point of view in order to be=20
closer to the HW implementation:

                              +-> /2 -> M2
                              |
                    +-> M2x2 -+------->
                    |=09
  DPLL ---> DPLLx2 -+-----------------> M3 (should be M3x2)
                    |
                    +-----------------> M4 (should be M4x2)
                    |
                    +-----------------> M5 (should be M5x2)
                    |
                    +-----------------> M6 (should be M6x2)
                    |
                    +-----------------> M7 (should be M7x2)


All DPLL, except the USB one, will use the same pattern. Only the numbe=
r=20
of HS dividers will change.

=46or information, here is an extract from the ES1 DB. The HS name is
indeed not very consistent.
There is no x2 in the HS dividers name whereas it should.

      'dpll_abe': {
          'outputs': {
              'm2': 'dpll_abe_m2',
              'm2x2': 'dpll_abe_m2x2',
              'm3': 'dpll_abe_m3'},
      'dpll_core': {
          'outputs': {
              'm2': 'dpll_core_m2',
              'm3': 'dpll_core_m3',
              'm4': 'dpll_core_m4',
              'm5': 'dpll_core_m5',
              'm6': 'dpll_core_m6',
              'm7': 'dpll_core_m7'},
      'dpll_iva': {
          'outputs': {
              'm4': 'dpll_iva_m4',
              'm5': 'dpll_iva_m5'},
      'dpll_mpu': {
          'outputs': {
              'm2': 'dpll_mpu_m2'},
      'dpll_per': {
          'outputs': {
              'm2': 'dpll_per_m2',
              'm2x2': 'dpll_per_m2x2',
              'm3': 'dpll_per_m3',
              'm4': 'dpll_per_m4',
              'm5': 'dpll_per_m5',
              'm6': 'dpll_per_m6',
              'm7': 'dpll_per_m7'},
      'dpll_unipro': {
          'outputs': {
              'm2x2': 'dpll_unipro_m2x2'},
      'dpll_usb': {
          'outputs': {
              'clkdcoldo': 'dpll_usb_clkdcoldo',
              'm2': 'dpll_usb_m2'},


So we should probably rename all the m3..m7 with m3x2..m7x2 name.

> Also, I think we should make this change in a consistent way with reg=
ards
> to what the autogeneration scripts should generate.  This way, we won=
't
> have to redo it later and cause unnecessary patch noise.
>
> Perhaps you can help Beno=EEt update the autogeneration scripts for t=
he
> above changes?

You can ask Rajendra if you need some detail about the tools.

Regards,
Benoit
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
