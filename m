From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH 3/6] Regulator: Use common regulator supplies and init
	data structs
Date: Tue, 12 Jan 2010 11:53:23 +0200
Message-ID: <6ed0b2681001120153n35526d78qec4321fbb62355e3@mail.gmail.com>
References: <1262973479-32570-1-git-send-email-anuj.aggarwal@ti.com>
	 <6ed0b2681001110441j75863ab8l467fdf2660328171@mail.gmail.com>
	 <5A47E75E594F054BAF48C5E4FC4B92AB031E1D7586@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f225.google.com ([209.85.220.225]:52512 "EHLO
	mail-fx0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751648Ab0ALJxZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Jan 2010 04:53:25 -0500
Received: by fxm25 with SMTP id 25so442789fxm.21
        for <linux-omap@vger.kernel.org>; Tue, 12 Jan 2010 01:53:23 -0800 (PST)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB031E1D7586@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>

On Tue, Jan 12, 2010 at 8:40 AM, Aggarwal, Anuj <anuj.aggarwal@ti.com> =
wrote:
>> Your common supply file has VMMC2 supply configured for 1.8V which i=
s
>> wrong for pandora (it uses 3.1V because it has a transceiver attache=
d
>> to MMC2 that handles level shifting transparently).
>>
>> I think you should leave pandora board file alone, because it uses
>> many supplies differently than your common file configures them
>> (VAUX1-VAUX4, VSIM differ, only VMMC1, VDAC and VPLL2 match, which i=
s
>> not that much duplication).
> [Aggarwal, Anuj] My mistake :(
> =A0Although I have marked it as RED in my notes, I still modified it.=
 I
> will leave VMMC2 in this file only.
> But I am not able to find so many regulators as you mentioned above i=
n
> this file. I can only see VMMC1 and VMMC2, out of which VMMC2 is
> different from the common configuration.
> Where is the gap?

They are not set up in l-o/mainline kernels yet (will send patches
later), this was just FYI.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
