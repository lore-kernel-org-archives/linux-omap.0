From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: Audio Click Issue on OMAP
Date: Tue, 11 Mar 2008 14:00:00 +0200
Message-ID: <20080311140000.2056a8b0.jarkko.nikula@nokia.com>
References: <cd1b82be0803110331m18c8ab9cq7e457fd26f34106e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:52004 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751999AbYCKMAG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Mar 2008 08:00:06 -0400
In-Reply-To: <cd1b82be0803110331m18c8ab9cq7e457fd26f34106e@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: suresh@mistralsolutions.com
Cc: linux-omap@vger.kernel.org, Khasim <khasim@ti.com>

On Tue, 11 Mar 2008 16:01:22 +0530
"ext Suresh Rajashekara" <suresh@mistralsolutions.com> wrote:

> Hi,
> 
> I am using the ALSA SoC driver on the OMAP2430 SDP. The codec
> initialization is being done in the soc->startup and uninitialized in
> the soc->shutdown routine. Since these routines gets executed every
> time some audio sample is played, there is a click noise heard just
> before the sample starts playing. Any idea how this can be resolved?
> 
It sounds that your codec driver doesn't integrate with DAPM concept of
ASoC? DAPM should take care of proper muting/unmuting and powering
order. Have a look in existing codec drivers for DAPM widgets and
dapm_event callbacks how they construct audio paths & widgets.


	Jarkko
