From: "Ashwin Bihari" <abihari@gmail.com>
Subject: Re: omapzoom tree broken?
Date: Tue, 9 Sep 2008 14:37:42 -0400
Message-ID: <1f11a5490809091137r66a9d91cl850ad6e034fe5844@mail.gmail.com>
References: <20080909175929.GK8894@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from el-out-1112.google.com ([209.85.162.178]:46082 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752762AbYIIShp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Sep 2008 14:37:45 -0400
Received: by el-out-1112.google.com with SMTP id z25so368273ele.1
        for <linux-omap@vger.kernel.org>; Tue, 09 Sep 2008 11:37:42 -0700 (PDT)
In-Reply-To: <20080909175929.GK8894@flint.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org

On Tue, Sep 9, 2008 at 1:59 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> When trying to fetch the omapzoom tree, I get:
>
> got a4ae90758b3c38012c875a62d0dd8a20a30e413b
> walk a4ae90758b3c38012c875a62d0dd8a20a30e413b
> Getting alternates list for http://git.omapzoom.org/repo/omapkernel
> Getting pack list for http://git.omapzoom.org/repo/omapkernel
> Getting index for pack 567cbb972dbfa42338e1269ca4a4a03ec2b1d35f
> Resuming fetch of index for pack 567cbb972dbfa42338e1269ca4a4a03ec2b1d35f at byte 5890048
> error: wrong index v1 file size in .git/objects/pack/pack-567cbb972dbfa42338e1269ca4a4a03ec2b1d35f.idx
> Segmentation fault
>
> Could we have it accessible via git the protocol please, rather than
> http?

Russell,

I just pulled the omapzoom tree for the first time and it had no
problems in the "git clone". Perhaps something to do with fetching
into an existing repo?

~ Ashwin
