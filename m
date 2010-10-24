From: Haribabu Narayanan <haribabu@iastate.edu>
Subject: [BeagleBoard] pm-2.6.34 hangs when cpufreq changed frequently
Date: Sat, 23 Oct 2010 20:06:17 -0500
Message-ID: <AANLkTik+eLOZQb4U480-0BGtwaSWzd2KVVr5zMdMrLoL@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:64978 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753555Ab0JXBGi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 23 Oct 2010 21:06:38 -0400
Received: by iwn34 with SMTP id 34so2704343iwn.19
        for <linux-omap@vger.kernel.org>; Sat, 23 Oct 2010 18:06:37 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

Hi all,

I working with pm-2.6.34 based kernel on Beagleboard.  I am not
working with later kernels because I need cpufreq (which is currently
not supported due to upgradation).

My project requires cpufreq transitions at inter-task/intra-task
levels and when I made the changes for that., it seems to be working
fine for some time.  However, after a few seconds, the system freezes
and it seems like it is freezing when the frequency is changed.  I
wish I could point out which function is executing when this happens,
however, the behaviour seems to be changing when i instrument the code
with printks.  But, based on a few runs, it looks like usually the
system freezes when arch\arm\mach-omap2\Resource34xx.c::program_opp()
is invoked.

I understand sometime down the line when cpufreq is enabled again in
linux-omap-pm, I might not have this issue at all.  However, as I am
stuck with pm-2.6.34 for now, has anybody seen this kind of a problem
before?  and is there any way to avoid this (other than possibly
reducing the frequency of changes to cpufreq)?

-hari
