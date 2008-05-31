From: astralstorm@gen2.org
Subject: Re: 2.6.26-rc3-omap vs N810 and Xomap
Date: Sat, 31 May 2008 13:31:53 +0200 (CEST)
Message-ID: <60878.89.77.116.159.1212233513.squirrel@gen2.org>
References: <20080525203855.2f6037f6@gen2.org>
    <20080528054654.GS8845@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gen2.org ([194.181.7.159]:36317 "EHLO gen2.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751965AbYEaLbz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 31 May 2008 07:31:55 -0400
In-Reply-To: <20080528054654.GS8845@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Radoslaw Szkodzinski <astralstorm@gen2.org>, linux-omap@vger.kernel.org

> * Radoslaw Szkodzinski <astralstorm@gen2.org> [080525 11:49]:
>> Hello,
>>
>> I've managed to get 2.6.26-rc3-omap booting (was quite easy actually).
>> Now I hit a road block - I get everything to start, it boots nicely
>> (checked with SSH), but fails to display anything except a white screen.
>> Looks like Xomap can't (re)init framebuffer, or focus isn't transferred
>> to it.
>> Any known possible reasons?
>
> Do you have any patches applied in addition to patching the machine_id?
>

Yes, muru.com patches, but these shouldn't cause that.

> I don't know about xomap, but last time I tried xserver-xorg-xfbdev
> from debian unstable worked. That is, without touchscreen until this
> patch is merged:
>
> https://bugs.launchpad.net/ubuntu/+source/xorg-server/+bug/219424
>
> Are you starting xomap from chroot?

System boots from initramfs and is pivot_rooted. Technically, it's not a
chroot. It's almost the default N810 initramfs.


