From: Ashwin Bihari <abihari@gmail.com>
Subject: Re: Kernel support of the Zoom OMAP35X Development kit
Date: Wed, 25 Mar 2009 13:20:42 -0400
Message-ID: <1f11a5490903251020o40ec542dyd44a2098c273a211@mail.gmail.com>
References: <49CA662B.6000104@balister.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.246]:22560 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751060AbZCYRUq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Mar 2009 13:20:46 -0400
Received: by an-out-0708.google.com with SMTP id d14so113516and.1
        for <linux-omap@vger.kernel.org>; Wed, 25 Mar 2009 10:20:44 -0700 (PDT)
In-Reply-To: <49CA662B.6000104@balister.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Philip Balister <philip@balister.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, Mar 25, 2009 at 1:13 PM, Philip Balister <philip@balister.org> wrote:
> I looked at the kit kernel and didn't see support for this board:
>
> http://www.logicpd.com/products/devkit/ti/zoom_omap3_development_kit
>
> What are my chances getting this board going with the Linux-omap git kernel?
>
> If that doesn't work, what boards give easy access to the GPMC pins and work
> with the linux-omap kernel?
>
> Philip
>

Philip,

We have support for the OMAP3530LV_SOM (the LogicPD DevKit in the
link) on 2.6.28-rc8. We have patches available against that particular
release of the Linux OMAP tree and that'll get you up to speed on the
SOM to do your work. Register yourself on the website and you should
get access to the patches there.

Regards

-- Ashwin
