From: Ming Lei <ming.lei@canonical.com>
Subject: Re: [PATCH v5 4/7] arm: omap4: hwmod: introduce emu hwmod
Date: Mon, 21 Nov 2011 23:30:02 +0800
Message-ID: <CACVXFVMFA4ry2fg3o8O9r0BFnUbbHZ6bg_fYzNhbXpobCEcfqw@mail.gmail.com>
References: <1319467559-5518-5-git-send-email-ming.lei@canonical.com>
	<alpine.DEB.2.00.1111080750130.10451@utopia.booyaka.com>
	<CACVXFVMSJUT2Ac+bWetrLpbyOs6PqY+npNHsbvHipEVZ0gWdgQ@mail.gmail.com>
	<alpine.DEB.2.00.1111100152430.4195@utopia.booyaka.com>
	<4EC6566C.70202@ti.com>
	<20111118145635.GB17991@mudshark.cambridge.arm.com>
	<CACVXFVNuz62+2DzOks3-0io2Ni=LK5SJienU4GcGRMtkh92vvQ@mail.gmail.com>
	<alpine.DEB.2.00.1111192019200.30133@utopia.booyaka.com>
	<20111121135828.GC20611@mudshark.cambridge.arm.com>
	<CACVXFVMzmjzi=3YxSG8EP+eb=8pe9Oo50MBmn+_cdkaVJkyGdA@mail.gmail.com>
	<20111121151612.GF20611@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:54373 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755428Ab1KUPaF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Nov 2011 10:30:05 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174])
	by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_ARCFOUR_SHA1:16)
	(Exim 4.71)
	(envelope-from <ming.lei@canonical.com>)
	id 1RSVoq-0002ie-Cw
	for linux-omap@vger.kernel.org; Mon, 21 Nov 2011 15:30:04 +0000
Received: by ghbz2 with SMTP id z2so2901454ghb.19
        for <linux-omap@vger.kernel.org>; Mon, 21 Nov 2011 07:30:02 -0800 (PST)
In-Reply-To: <20111121151612.GF20611@mudshark.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: Paul Walmsley <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "tony@atomide.com" <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>

On Mon, Nov 21, 2011 at 11:16 PM, Will Deacon <will.deacon@arm.com> wro=
te:
> On Mon, Nov 21, 2011 at 02:53:54PM +0000, Ming Lei wrote:
>> On Mon, Nov 21, 2011 at 9:58 PM, Will Deacon <will.deacon@arm.com> w=
rote:
>> > On Sun, Nov 20, 2011 at 03:27:19AM +0000, Paul Walmsley wrote:
>> >> The OMAP-specific parts should be queued up in my/Beno=EEt's/Tony=
's trees,
>> >> rather than placed directly into -next. =A0Otherwise they are lik=
ely to
>> >> generate merge conflicts with other OMAP changes that we may gene=
rate.
>> >>
>> >> So I'd suggest splitting patches 1-3 off into a separate series t=
hat Will
>> >> can pass on to -next if he wishes.
>> >
>> > Fine by me. If Ming Lei posts a new series so that everything is i=
n one
>> > thread then I can pick out the bits I want.
>>
>> You mean the 3rd patch is the debugss patch posted by Benoit?
>> The original 3rd patch is not needed any more once the debugss patch
>> is taken.
>
> Ah sorry, I lost track a bit. In that case, I'll just keep hold of th=
e two
> patches I have and deal with them appropriately.

Sorry too, :-)

It should be that both 3/7 and 4/7 are not needed any more.
Benoit's debugss patch will replace the 4/7 patch(introduce emu hwmod).

thanks,
--
Ming Lei
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
