From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: OMAP 3430SDP i2c boot crash
Date: Fri, 16 Apr 2010 22:31:23 +0300
Message-ID: <z2g6ed0b2681004161231gc1dede07uaba95d5f6cf415c0@mail.gmail.com>
References: <1271406087.2690.286.camel@tubuntu.research.nokia.com>
	 <loom.20100416T130220-732@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f225.google.com ([209.85.218.225]:41990 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757978Ab0DPTbZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Apr 2010 15:31:25 -0400
Received: by bwz25 with SMTP id 25so3543980bwz.28
        for <linux-omap@vger.kernel.org>; Fri, 16 Apr 2010 12:31:23 -0700 (PDT)
In-Reply-To: <loom.20100416T130220-732@post.gmane.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nahamo <w.mohanrao@gmail.com>
Cc: linux-omap@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>

On Fri, Apr 16, 2010 at 2:07 PM, Nahamo <w.mohanrao@gmail.com> wrote:
> Tomi Valkeinen <tomi.valkeinen <at> nokia.com> writes:
>
>>
>> Hi,
>>
>> I haven't been able to boot my OMAP 3430SDP board with mainstream ke=
rnel
>> for a while, with the omap_3430sdp_defconfig. Anyone else having
>> problems? I don't get anything on the console after "Uncompressing
>> Linux... done, booting the kernel.", and Trace32 shows the log below=
=2E
>>
>> =A0Tomi
<snip>
>
> Hi Tomi,
> i am also getting exactly the same error.
> Thanks

You need this patch:
https://patchwork.kernel.org/patch/87590/

it's still not reached mainline for some reason..
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
