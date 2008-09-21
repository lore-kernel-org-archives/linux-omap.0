From: "Felipe Contreras" <felipe.contreras@gmail.com>
Subject: Re: OMAP support in mainline?
Date: Sun, 21 Sep 2008 18:02:57 +0300
Message-ID: <94a0d4530809210802ua99461s71c57fe722758c4a@mail.gmail.com>
References: <87tzcgi1gv.fsf@nokia.com>
	 <5e088bd90809170524s6cfae9b9ye1379f11afb5bb79@mail.gmail.com>
	 <8192948C-751F-4C1C-B382-E381F903CC46@student.utwente.nl>
	 <20080918095537.GD28615@gandalf.research.nokia.com>
	 <DC3E0288-2605-450F-9E54-9B170B7669C9@student.utwente.nl>
	 <FCCFB4CDC6E5564B9182F639FC356087022A3162A3@dbde02.ent.ti.com>
	 <1221738810.3873.37.camel@localhost>
	 <13B9B4C6EF24D648824FF11BE896716203657701DB@dlee02.ent.ti.com>
	 <1221814185.31752.11.camel@localhost>
	 <13B9B4C6EF24D648824FF11BE896716203657CA5E8@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.239]:28781 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751823AbYIUPDA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 21 Sep 2008 11:03:00 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1189691rvb.1
        for <linux-omap@vger.kernel.org>; Sun, 21 Sep 2008 08:02:57 -0700 (PDT)
In-Reply-To: <13B9B4C6EF24D648824FF11BE896716203657CA5E8@dlee02.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: "igor.stoppa@nokia.com" <igor.stoppa@nokia.com>, Koen Kooi <k.kooi@student.utwente.nl>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>, "Pandita, Vikram" <vikram.pandita@ti.com>

On Fri, Sep 19, 2008 at 4:50 PM, Woodruff, Richard <r-woodruff2@ti.com> wrote:
> Hi Igor,
>
>> -----Original Message-----
>> > Where do you think the lineage of the hardware and software is?  Do
>> you believe it just jumped into being in open source?  All hardware and
>> software is full of deliberate design and hacks. Its true cooperate
>> design constraints are driven by the bottom line and for some in open
>> source it is not.
>>
>> Getting the HW to work somewhere is not good enough. It must be
>> supported in mainline, the more code you generate out of mainline, the
>> less likely anybody can get it to work after a while and it slows down
>> everybody.
>
> Sure. In this case I'm just airing some frustration. It is not like some version of this isn't already shipping years back in N800. Rapid development/advancement is great but there should be a working spot which isn't by just by chance.
>
> In this case a tree is just like a branch.  We have done some new development outside on this branch to enable a new dma mode to boost performance.  Hopefully that will be folded back in before too much time. I think I've seen a patch even. In the past we would have just 2x the performance on some old kernel and made it available.  But probably so out of phase you really had to work to get it.  Today using a current tree it is there and there is a lot better chance we or some community person will push it back.

Nobody cares about tree vs branch, the problem is that the branch is
forked from way back in the history.

If you want your changes to be merged you need to rebase continuously,
and not have a single ompazoom branch, but many. That way people can
pick the patches they are interested in.

The difference is a branch for changes to-be-merged vs a fork.

For the vast majority of people, code that is not in upstream, is code
that doesn't exist. That's why good branches should be temporal forks;
as short in time as possible. Permanent forks go against
collaboration.

-- 
Felipe Contreras
