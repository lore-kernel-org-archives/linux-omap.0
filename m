From: Nishanth Menon <nm@ti.com>
Subject: Re: [PM-WIP-OPP][PATCH 3/4] omap: pm: opp: add ability to store data
 per opp
Date: Tue, 23 Mar 2010 08:00:07 -0500
Message-ID: <4BA8BB57.9030307@ti.com>
References: <1268937891-19445-1-git-send-email-nm@ti.com> <1268937891-19445-2-git-send-email-nm@ti.com> <1268937891-19445-3-git-send-email-nm@ti.com> <1268937891-19445-4-git-send-email-nm@ti.com> <20100319144333.GU18995@nokia.com> <4BA3975E.70206@ti.com> <74583B8642AB8841B30447520659FCA9EBAC2C6A@dnce01.ent.ti.com> <4BA770D6.9020707@ti.com> <74583B8642AB8841B30447520659FCA9EBAC3458@dnce01.ent.ti.com> <4BA7B601.1060504@ti.com> <5A47E75E594F054BAF48C5E4FC4B92AB03220FC0C3@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56771 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753147Ab0CWNAQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Mar 2010 09:00:16 -0400
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB03220FC0C3@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gopinath, Thara" <thara@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, Linux-Omap <linux-omap@vger.kernel.org>, "K, Ambresh" <ambresh@ti.com>, "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Carmody Phil.2 (EXT-Ixonos/Helsinki)" <ext-phil.2.carmody@nokia.com>, "Premi, Sanjeev" <premi@ti.com>, "Kristo Tero (Nokia-D/Tampere)" <Tero.Kristo@nokia.com>

Gopinath, Thara had written, on 03/23/2010 12:06 AM, the following:
> 
>>> [...] [I am not about to repeat everything I stated in previous
>>> threads.. so  snipping the discussion down.]
>>>
>>>> Otherwise the primary idea to remove OPP ID is good, and the way to go.
>>> good. So lets NAK that SR series and see how else we can implement it
>>> without OPP ID. I am open to any clean mechanisms you may propose
>>> without using OPP ID referencing :).
> 
> Ok guys.. In the current V2 series , I have linked N targets with voltage..
 > Only it does not come from voltage layer but from smartreflex devices 
layer.
 > The smartreflex driver does not use opp ids at all.. Also whether you 
call
 >it by opp ids or by any other name, we need to know the number of 
different
 > voltages supported by VDD1 and VDD2 and form the table.. That is exactly
 >what I am doing in smartreflex device layer. I am just creating a 
table with
 >different voltages and N target values associated with those voltages.
 > To create this table I need to know there should be 5 voltages for VDD1
 > and 3 voltages for VDD2 which unfortunately coincides with the number of
 > different OPP's defined in OMAP3430 today..
SR patches should ideally be discussed in SR patch series context 
anyways, since we are looking at the fundamentals of OPP:
3430: VDD1: 5 voltages+frequencies, VDD2: 3 voltages and frequencies
3630: VDD1: 4 voltages+frequencies, VDD2: 2 voltages and frequencies
are there cases where the number of discrete voltage != number of 
supported frequencies?

Agreed that for a voltage the characteristic data is unique. but since a 
voltage is tied to a frequency, does'nt it make sense to tie it to an 
OPP (my initial point in the first place)?

look at the amount of redundant data:
  static void __init omap34xx_sr_volt_details(struct omap_smartreflex_data
                                                  *sr_data, int srid)
  {
          if (srid == SR1) {
                  sr_data->no_opp = opp_get_opp_count(OPP_MPU);
                  sr_data->sr_volt_data = 
kzalloc(sizeof(sr_data->sr_volt_data) *
                                  sr_data->no_opp , GFP_KERNEL);
                  WARN_ON(!sr_data->sr_volt_data);
                  sr_data->sr_volt_data[0].voltage = 975000;
                  sr_data->sr_volt_data[1].voltage = 1075000;
                  sr_data->sr_volt_data[2].voltage = 1200000;
                  sr_data->sr_volt_data[3].voltage = 1270000;
                  sr_data->sr_volt_data[4].voltage = 1350000;
          } else if (srid == SR2) {
                  sr_data->no_opp = 3;
                  sr_data->sr_volt_data = 
kzalloc(sizeof(sr_data->sr_volt_data) *
                                  sr_data->no_opp , GFP_KERNEL);
                  WARN_ON(!sr_data->sr_volt_data);
                  sr_data->sr_volt_data[0].voltage = 975000;
                  sr_data->sr_volt_data[1].voltage = 1050000;
                  sr_data->sr_volt_data[2].voltage = 1150000;
          }
  }

If you link sr_volt_data with OPP, you have a simple scalable soln 
without having to manage voltage in multiple places etc.

the implementation is definitely based on number of OPPs :). and it is 
not exactly the most scalable implementation currently present.
> I also think it is an excellent idea to NAK a series of 19 patches for
 > which everybody has been shouting for, for this reason.
NAK was for SRID usage and voltage indexing which makes scaling across 
silicon variants troublesome.

-- 
Regards,
Nishanth Menon
