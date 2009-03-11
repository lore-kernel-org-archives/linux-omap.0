From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [Linux-fbdev-devel] [PATCH] omapfb: Fix argument of blank
	operation.
Date: Thu, 12 Mar 2009 00:43:18 +0200
Message-ID: <94a0d4530903111543y4745ade0ofac867ef43e7ab1b@mail.gmail.com>
References: <1228430755-4221-1-git-send-email-felipe.contreras@gmail.com>
	 <5d5443650903111017n9c818b0y2119d06ea84c3abf@mail.gmail.com>
	 <20090311152000.8a3db19c.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f176.google.com ([209.85.220.176]:59379 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753045AbZCKWnW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Mar 2009 18:43:22 -0400
In-Reply-To: <20090311152000.8a3db19c.akpm@linux-foundation.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Trilok Soni <soni.trilok@gmail.com>, linux-fbdev-devel@lists.sourceforge.net, linux-omap@vger.kernel.org, felipe.contreras@nokia.com, linux-kernel@vger.kernel.org

On Thu, Mar 12, 2009 at 12:20 AM, Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Wed, 11 Mar 2009 22:47:41 +0530
> Trilok Soni <soni.trilok@gmail.com> wrote:
>
>> Hi Felipe,
>>
>> On Fri, Dec 5, 2008 at 4:15 AM, Felipe Contreras
>
> I bet he thought we'd forgotten.

You bet correctly :)

>> <felipe.contreras@gmail.com> wrote:
>> > From: Felipe Contreras <felipe.contreras@nokia.com>
>> >
>> > The blank operation should receive FB_BLANK_POWERDOWN, not
>> > VESA_POWERDOWN.
>> >
>>
>> Thanks. Looks good.
>>
>> Signed-off-by: Trilok Soni <soni.trilok@gmail.com>
>>
>
> Unfortunately the changelog didn't give me any hint as to the
> seriousness of the problem which was fixed. =C2=A0So I queued it for =
2.6.30,
> perhaps inappropriately.

I noticed because of another bug in omapfb which required blanking in
order to actually see something (PM stuff?). If user-space tries to
blank the usual way, it wouldn't work.

My guess is that it's not a big issue, in part because nobody has
noticed, but perhaps I'm wrong. I was hoping the fbdev guys would know
better.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
