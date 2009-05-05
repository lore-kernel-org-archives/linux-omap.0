From: Rebecca Schultz Zavin <rschultz@google.com>
Subject: Re: Anyone have MUSB working on PM branch?
Date: Mon, 4 May 2009 18:05:12 -0700
Message-ID: <aed62de90905041805s74cba19cu2db014fa4f792cc4@mail.gmail.com>
References: <1241201214.18100.362.camel@blackhole> <49FC137F.70809@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.33.17]:2001 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753618AbZEEBFQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 May 2009 21:05:16 -0400
Received: from wpaz33.hot.corp.google.com (wpaz33.hot.corp.google.com [172.24.198.97])
	by smtp-out.google.com with ESMTP id n4515Ep5020082
	for <linux-omap@vger.kernel.org>; Tue, 5 May 2009 02:05:15 +0100
Received: from rv-out-0708.google.com (rvbf25.prod.google.com [10.140.82.25])
	by wpaz33.hot.corp.google.com with ESMTP id n4515CHa002975
	for <linux-omap@vger.kernel.org>; Mon, 4 May 2009 18:05:13 -0700
Received: by rv-out-0708.google.com with SMTP id f25so3295946rvb.34
        for <linux-omap@vger.kernel.org>; Mon, 04 May 2009 18:05:12 -0700 (PDT)
In-Reply-To: <49FC137F.70809@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Eugeny S. Mints" <eugeny.mints@gmail.com>
Cc: Peter Barada <peterb@logicpd.com>, linux-omap <linux-omap@vger.kernel.org>

I'm pretty sure we do, though I doubt we have it doing the right thing
across power events, we're still in the process of getting all our
drivers to behave.  Check out the android omap tree:

http://android.git.kernel.org/?p=3Dkernel/omap.git;a=3Dshortlog;h=3Dref=
s/heads/android-omap-2.6.29

Rebecca

On Sat, May 2, 2009 at 2:33 AM, Eugeny S. Mints <eugeny.mints@gmail.com=
> wrote:
> Peter,
>
> Peter Barada wrote:
>>
>> All,
>>
>>
>
> [skip]
>>
>> 1) Has anyone gotten the MUSB in the latest PM branch working?
>>
>
> I believe MUSB has not yet been validated on the PM branch as of 4/29
> according to Kevin.
>
> Eugeny
>>
>> 2) Outside of setting up the pinmux, is there anything else necessar=
y to
>> get the MUSB to come up?
>>
>> 3) Any ideas on how to fix this?
>>
>>
>>
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
