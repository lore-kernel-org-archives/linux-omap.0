From: Ming Lei <ming.lei@canonical.com>
Subject: Re: [PATCH v5 4/7] arm: omap4: hwmod: introduce emu hwmod
Date: Mon, 21 Nov 2011 22:53:54 +0800
Message-ID: <CACVXFVMzmjzi=3YxSG8EP+eb=8pe9Oo50MBmn+_cdkaVJkyGdA@mail.gmail.com>
References: <1319467559-5518-1-git-send-email-ming.lei@canonical.com>
	<1319467559-5518-5-git-send-email-ming.lei@canonical.com>
	<alpine.DEB.2.00.1111080750130.10451@utopia.booyaka.com>
	<CACVXFVMSJUT2Ac+bWetrLpbyOs6PqY+npNHsbvHipEVZ0gWdgQ@mail.gmail.com>
	<alpine.DEB.2.00.1111100152430.4195@utopia.booyaka.com>
	<4EC6566C.70202@ti.com>
	<20111118145635.GB17991@mudshark.cambridge.arm.com>
	<CACVXFVNuz62+2DzOks3-0io2Ni=LK5SJienU4GcGRMtkh92vvQ@mail.gmail.com>
	<alpine.DEB.2.00.1111192019200.30133@utopia.booyaka.com>
	<20111121135828.GC20611@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:51776 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751274Ab1KUOx5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Nov 2011 09:53:57 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174])
	by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_ARCFOUR_SHA1:16)
	(Exim 4.71)
	(envelope-from <ming.lei@canonical.com>)
	id 1RSVFs-00088m-1Y
	for linux-omap@vger.kernel.org; Mon, 21 Nov 2011 14:53:56 +0000
Received: by ggnr5 with SMTP id r5so2397015ggn.19
        for <linux-omap@vger.kernel.org>; Mon, 21 Nov 2011 06:53:54 -0800 (PST)
In-Reply-To: <20111121135828.GC20611@mudshark.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: Paul Walmsley <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "tony@atomide.com" <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>

Hi,

On Mon, Nov 21, 2011 at 9:58 PM, Will Deacon <will.deacon@arm.com> wrot=
e:
> On Sun, Nov 20, 2011 at 03:27:19AM +0000, Paul Walmsley wrote:
>> The OMAP-specific parts should be queued up in my/Beno=EEt's/Tony's =
trees,
>> rather than placed directly into -next. =A0Otherwise they are likely=
 to
>> generate merge conflicts with other OMAP changes that we may generat=
e.
>>
>> So I'd suggest splitting patches 1-3 off into a separate series that=
 Will
>> can pass on to -next if he wishes.
>
> Fine by me. If Ming Lei posts a new series so that everything is in o=
ne
> thread then I can pick out the bits I want.

You mean the 3rd patch is the debugss patch posted by Benoit?
The original 3rd patch is not needed any more once the debugss patch
is taken.

thanks,
--
Ming Lei
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
