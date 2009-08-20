From: Gary Thomas <gary@mlbassoc.com>
Subject: Re: Booting from busy box failed
Date: Thu, 20 Aug 2009 09:02:31 -0600
Message-ID: <4A8D6587.2090500@mlbassoc.com>
References: <d9ca78710908192215r2812d61u5cc627a1e6e22f15@mail.gmail.com>	 <4A8D2D14.2060000@mlbassoc.com> <d9ca78710908200739h342f1590madf7554d762a2968@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hermes.mlbassoc.com ([76.76.67.137]:5383 "EHLO
	mail.chez-thomas.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754425AbZHTPCn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Aug 2009 11:02:43 -0400
In-Reply-To: <d9ca78710908200739h342f1590madf7554d762a2968@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tar Gz <bsdraisefromhell@gmail.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

Tar Gz wrote:
> directory /proc in the second partition(my filesystem) and my kernel
> configure to support proc filesystems...any idea?

First of all, don't top post :-(

Why are you running "/etc/init.d/rcS" manually?  It looks to me
like it already ran & /proc should already be mounted.

What does the output of "mount" show?

> On 8/20/09, Gary Thomas <gary@mlbassoc.com> wrote:
>> Tar Gz wrote:
>>> hi all,
>>> i try to using linux 2.6.26-omap1 at omap3430
>>>
>>> it's my env variable
>>>
>>> OMAP34XX LAB # print
>>> bootdelay=3
>>> baudrate=115200
>>> filesize=34a8
>>> bootfile="uImage"
>>> bootargs=console=ttyS2,115200n8 rw root=/dev/mmcblk0p2 rootdelay=2
>>> mem=128M
>>>
>>> #mmcinit
>>> #fatload mmc 0 80300000
>>> #bootm 80300000
>>>
>>> ******************************************
>>> Starting System Init for OMAP3430LAB
>>> Release: 0.1
>>> ******************************************
>>> Saving kernel ring buffer : OK
>>> Mounting devpts : OK
>>> Starting syslogd : OK
>>> Starting klogd : OK
>>> Mounting filesystems : OK
>>>
>>> Please press Enter to activate this console.
>>>
>>>
>>> BusyBox v1.6.1 (2008-07-17 12:54:29 CDT) Built-in shell (ash)
>>> Enter 'help' for a list of built-in commands.
>>>
>>> #
>>>
>>> then i try to type :
>>>
>>> # /etc/init.d/rcS
>>> Mounting proc : mount: mounting /proc on /proc failed
>>> Error in /proc filesystem - init aborted
>>>
>> Does the directory [mount point] '/proc' exist?

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
