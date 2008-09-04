From: "Steve Sakoman" <sakoman@gmail.com>
Subject: Re: Errors on boot with 2.6.27-rc5 on omap3
Date: Wed, 3 Sep 2008 23:04:13 -0700
Message-ID: <5e088bd90809032304k3e8bbd8cncea40b90ff6ab340@mail.gmail.com>
References: <5e088bd90809032041u69a60e71h4c22cfa3ce06ec86@mail.gmail.com>
	 <200809032210.31687.david-b@pacbell.net>
	 <5e088bd90809032227v56039032v881cc4fed61b676c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.28]:24488 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751165AbYIDGEO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Sep 2008 02:04:14 -0400
Received: by yx-out-2324.google.com with SMTP id 8so1819816yxm.1
        for <linux-omap@vger.kernel.org>; Wed, 03 Sep 2008 23:04:13 -0700 (PDT)
In-Reply-To: <5e088bd90809032227v56039032v881cc4fed61b676c@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, Sep 3, 2008 at 10:27 PM, Steve Sakoman <sakoman@gmail.com> wrote:
> On Wed, Sep 3, 2008 at 10:10 PM, David Brownell <david-b@pacbell.net> wrote:
>> On Wednesday 03 September 2008, Steve Sakoman wrote:
>>> I get similar results for both Beagle and Overo, so the error occurs
>>> for both nand and onenand.  The boot eventually completes, of course
>>> without nand/onenand support.
>>
>> Does this help?
>>
>>  http://marc.info/?l=linux-kernel&m=121999823616458&w=2
>>
>> Block layer goofage; that patch is in Jens' queue.

The above mentioned patch does fix the issue.

Steve
