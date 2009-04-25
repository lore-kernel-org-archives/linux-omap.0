From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH][UPDATED] DSPBRIDGE: CLK_Enable and CLK_Disable Code
	cleanup
Date: Sat, 25 Apr 2009 14:42:49 +0300
Message-ID: <94a0d4530904250442h5888d61fie0f2ec60f6384ab7@mail.gmail.com>
References: <49E89649.9050103@yandex.ru>
	 <1239981547-30944-1-git-send-email-ameya.palande@nokia.com>
	 <49E8A50D.2010602@yandex.ru>
	 <27F9C60D11D683428E133F85D2BB4A530404A089E0@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.158]:43410 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751159AbZDYLmu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 25 Apr 2009 07:42:50 -0400
Received: by fg-out-1718.google.com with SMTP id d23so312121fga.17
        for <linux-omap@vger.kernel.org>; Sat, 25 Apr 2009 04:42:49 -0700 (PDT)
In-Reply-To: <27F9C60D11D683428E133F85D2BB4A530404A089E0@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <x00omar@ti.com>
Cc: Artem Bityutskiy <dedekind@yandex.ru>, Ameya Palande <ameya.palande@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, Apr 17, 2009 at 8:45 PM, Ramirez Luna, Omar <x00omar@ti.com> wrote:
> Hi,
>
> Artem Bityutskiy wrote:
>>
>>I'm sorry. Authors of the code may delete this e-mail.
>>More flame and suggestions.
>>
>
> Thanks for your suggestions; it is true that bridge code has been out for a while, almost a year I think, and we are still trying to enhance it and clean it up along the way, although it may seem we have stalled on the task.
>
> Please friendly flame about other parts of bridge code too ;) as we can take very good points of your's/everyone's comments and try to put in better shape the driver to be pushed into mainline (as this has been the goal all the time). Thanks for the time reviewing the code.

The purpose of this mailing list is not to make friends, it's to
develop good quality software. You might not like this "unfriendly"
approach, but it is the style of many linux maintainers, and I believe
for good reason.

When you think the code is ugly, and you want the message to get
across effectively you say it's ugly. This might hurt some people
sensitivities but it's the truth, and sugar-coating will not make the
code any less uglier.

While there has been good progress in the bridgedriver, it is still
*very* far away from meeting mainline standards and this makes many
people uneasy, including me.

Artem complains will need to be addressed one way or another. So, can
we have at least have a TODO file with these complaints?

-- 
Felipe Contreras
