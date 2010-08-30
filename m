From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 01/13] OMAP: Introduce a user list for each voltage domain instance in the voltage driver.
Date: Mon, 30 Aug 2010 15:56:00 -0700
Message-ID: <87fwxvyakf.fsf@deeprootsystems.com>
References: <1282130412-12027-1-git-send-email-thara@ti.com>
	<1282130412-12027-2-git-send-email-thara@ti.com>
	<87iq2vipe7.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:44481 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751791Ab0H3W4D (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Aug 2010 18:56:03 -0400
Received: by pwi3 with SMTP id 3so177659pwi.19
        for <linux-omap@vger.kernel.org>; Mon, 30 Aug 2010 15:56:03 -0700 (PDT)
In-Reply-To: <87iq2vipe7.fsf@deeprootsystems.com> (Kevin Hilman's message of
	"Fri, 27 Aug 2010 16:53:20 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, vishwanath.bs@ti.com, sawant@ti.com, b-cousson@ti.com

Kevin Hilman <khilman@deeprootsystems.com> writes:

>> +	if (!found) {
>> +		user = kzalloc(sizeof(struct omap_vdd_user_list), GFP_KERNEL);
>> +		if (!user) {
>> +			pr_err("%s: Unable to creat a new user for vdd_%s\n",
>> +				__func__, voltdm->name);
>> +			mutex_unlock(&vdd->scaling_mutex);
>> +			return -ENOMEM;
>> +		}
>> +		user->dev = dev;
>> +	} else {
>> +		plist_del(&user->node, &vdd->user_list);
>
> hmm... if we get here, we didn't find a match, so 'user' points to the
> last element in the list (which is the highest voltage request, I
> guess), or even NULL if the list is empty.  Then, this node is deleted.
>
> -ECONFUSED

OK, I'm a bit dense.

It took me a few reads, now I think I know what's going on here.

If we get here, we found a match, and you delete the existing value for
that device so that inserting a new one (with a new voltage) will be
kept in the right order.  Right?  

Some comments might help clarify things here.

Kevin
