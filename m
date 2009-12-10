From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: DSS2 and power supplies
Date: Thu, 10 Dec 2009 16:00:50 +0200
Message-ID: <6ed0b2680912100600p7584c0a0v60ded6e83c6df85d@mail.gmail.com>
References: <6ed0b2680912040253m3b25950fuf49e6ec75ad13067@mail.gmail.com>
	 <1260175482.2342.49.camel@tubuntu.research.nokia.com>
	 <6ed0b2680912070227x3bcb9613x88ebdb0b0a7f3f18@mail.gmail.com>
	 <19F8576C6E063C45BE387C64729E73940437210B71@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:18976 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758967AbZLJOAo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Dec 2009 09:00:44 -0500
Received: by fg-out-1718.google.com with SMTP id 16so556385fgg.1
        for <linux-omap@vger.kernel.org>; Thu, 10 Dec 2009 06:00:50 -0800 (PST)
In-Reply-To: <19F8576C6E063C45BE387C64729E73940437210B71@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, Dec 10, 2009 at 3:23 PM, Hiremath, Vaibhav <hvaibhav@ti.com> wrote:
<snip>

>> >
>> > To me the fig 15-1 does not tell that the powers are needed. The
>> > DSS_DATA[] pins do not come from SDI/DSI blocks, but from the main
>> DSS
>> > block. And the pin muxing component is outside also. This of
>> course
>> > doesn't really prove anything. =)
>>
>> True, but apparently vdds_dsi and/or vdds_sdi are also used to drive
>> some data lines then (not supplying them produces blue-ish display
>> with some parts missing). I'm working with pandora board, and I'm
>> sure
>> VPLL2 is not connected to anything else.
>>
> [Hiremath, Vaibhav] No, I think the "vdds_dsi" doesn't drive any data in parallel mode of operation.
> I have also observed similar issue with OMAP3EVM, when you switch the output to DVI interface, you will get bluish image.
>
> The issue came out as VPLL2_DEV_GRP (Bits 7-5) register configuration. When you are working with LCD panel (in my case sharp-ls037v7dw01.c), this file calls regulator_get and regulator_enable functions which configures VPLL2_DEV_GRP to 0x2 [Owns to P1 device group].
> But when you switch the output to DVI, it doesn't do any regulator_get/enable call so the VPLL2_DEV_GRP register becomes 0 [Owns to no device group] leading to color loss.
>
> I am not regulator framework expert, so could not comment on what is the relation of VPLL2_DEV_GRP with this issue.
>
> So what is required here is, panel_generic.c also should enable regulator for "vdvi"
>
> I have a patch (tested on OMAP3EVM) which I submit once DSS2 goes in.

I think this regulator is misnamed, does VPLL2 really power DVI on
OMAP3EVM? Can you check the schematics? At least on pandora it's
connected to vdds_dsi/vdds_sdi and has nothing to do with the panel.
