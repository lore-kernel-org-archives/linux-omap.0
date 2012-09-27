From: linux@johnea.net
Subject: Re: Which git to clone for testing prior to submitting bugs?
Date: Thu, 27 Sep 2012 11:56:51 -0700
Message-ID: <5064A173.5000909@johnea.net>
References: <50648AA2.2010004@johnea.net> <CAOCHtYitbhOMv+YBaYgdTuYZQpZ_VLoP=QKVS=spmqPxEUkATA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from johnea.net ([70.167.123.7]:58918 "EHLO mail.johnea.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754082Ab2I0S4x (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 27 Sep 2012 14:56:53 -0400
Received: from [192.168.1.143] (wsip-70-166-88-164.sd.sd.cox.net [70.166.88.164])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.johnea.net (Postfix) with ESMTPSA id B426873F188B
	for <linux-omap@vger.kernel.org>; Thu, 27 Sep 2012 11:56:52 -0700 (PDT)
In-Reply-To: <CAOCHtYitbhOMv+YBaYgdTuYZQpZ_VLoP=QKVS=spmqPxEUkATA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

On 09/27/2012 11:25 AM, Robert Nelson wrote:
> On Thu, Sep 27, 2012 at 12:19 PM,<linux@johnea.net>  wrote:
>>
>> Hello,
>>
>> In a subsequent distro upgrade to 3.4.4 neither dvi, nor buddy=spidev
>> function anymore.
>
> "buddy=xyz" is not upstream, so which 'tree'/'patchset' are you
> currently using as a basis for your device?  The authors of that
> patchset might be able to help out..
>

Thanks Robert,

The 3.4.4 kernel is plain vanilla plus:

http://rcn-ee.net/deb/sid-armhf/v3.4.4-x1/patch-3.4.4-x1.diff.gz

We're running archlinuxarm, and working with devs there to upgrade to 3.5.4, in hopes this will address most or all of the issues. That will include:

http://rcn-ee.net/deb/sid-armhf/v3.5.4-x6/patch-3.5.4-x6.diff.gz

We adopted archlinux because it's about as close to a git kernel as can be had in a disto packaged format.

If we still experience issues, I'm trying to understand what to clone to be relevant to this list.

Which tree are patches submitted against here?

Thanks again!

johnea

