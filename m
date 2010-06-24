From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 06/13] OMAP: hwmod: add non-locking versions of enable and idle functions
Date: Thu, 24 Jun 2010 10:55:16 -0700
Message-ID: <87zkykco3f.fsf@deeprootsystems.com>
References: <1277336563-24988-1-git-send-email-khilman@deeprootsystems.com>
	<1277336563-24988-7-git-send-email-khilman@deeprootsystems.com>
	<alpine.DEB.2.00.1006232307170.1550@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:62334 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753033Ab0FXRzU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Jun 2010 13:55:20 -0400
Received: by pzk3 with SMTP id 3so266464pzk.19
        for <linux-omap@vger.kernel.org>; Thu, 24 Jun 2010 10:55:19 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1006232307170.1550@utopia.booyaka.com> (Paul
	Walmsley's message of "Wed, 23 Jun 2010 23:08:59 -0600 (MDT)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

Paul Walmsley <paul@pwsan.com> writes:

> Hi Kevin
>
> On Wed, 23 Jun 2010, Kevin Hilman wrote:
>
>> Some hwmods may need to be idled/enabled in atomic context, so
>> non-locking versions of these functions are required.
>> 
>> Most users should not need these and usage of theses should be
>> controlled to understand why access is being done in atomic context.
>> For this reason, the non-locking functions are only exposed at the
>> hwmod level and not at the omap-device level.
>> 
>> The use-case that led to the need for the non-locking versions is
>> hwmods that are enabled/idled from within the core idle/suspend path.
>> Since interrupts are already disabled here, the mutex-based locking in
>> hwmod can sleep and will cause potential deadlocks.
>
> I accept the use-case.  But maybe it would be preferable to rename 
> _enable(), _idle(), _shutdown() to _omap_hwmod_{enable,idle,shutdown}() ?
> That would avoid the need to add new functions that just call the existing 
> ones.

OK, will make that change.

Kevin
