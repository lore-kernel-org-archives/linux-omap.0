From: Aneesh V <aneesh@ti.com>
Subject: Re: [RFC v2 PATCH 0/3] dt: device tree bindings and data for EMIF
 and DDR
Date: Tue, 17 Jan 2012 17:36:16 +0530
Message-ID: <4F156438.20502@ti.com>
References: <1324303533-17458-1-git-send-email-aneesh@ti.com>	<4EEFC23A.30201@gmail.com>	<20111219233559.GW6464@atomide.com>	<4EF0671B.7090508@ti.com>	<4EF0824A.9060208@ti.com>	<4EF096C9.1070808@ti.com>	<4F09D10B.7010807@ti.com> <CAOesGMjFmM=gXddvFzW+BYqOedySjPVZ6hjwsF-F40Wr9BvSLg@mail.gmail.com> <4F1087C9.6030908@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:45282 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753056Ab2AQMGZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Jan 2012 07:06:25 -0500
Received: by mail-yx0-f176.google.com with SMTP id l12so409214yen.21
        for <linux-omap@vger.kernel.org>; Tue, 17 Jan 2012 04:06:24 -0800 (PST)
In-Reply-To: <4F1087C9.6030908@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robherring2@gmail.com>, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Vishwanath Sripathy <vishwanath.bs@ti.com>, Mike Turquette <mturquette@ti.com>, grant.likely@secretlab.ca

Hi Olof,

On Saturday 14 January 2012 01:06 AM, Aneesh V wrote:
> Hi Olof,

<snip>

> We wish to drop the DDR3 support because we have concluded that our
> platforms with DDR3 memories will not scale DDR frequency due to
> limitations in DDR3 protocol(operating frequency can vary only in a
> small range). So, is it ok to persist with my bindings for LPDDR2
> (fixing the comments already given by you) and drop the DDR3 part
> from it?

Ping! Forgive my impatience, but I would like to close on this at the
earliest to continue my work on the driver.

thanks,
Aneesh
