From: Kevin Hilman <khilman@ti.com>
Subject: Re: context_loss_count error value
Date: Wed, 25 May 2011 13:30:36 -0700
Message-ID: <87tycitteb.fsf@ti.com>
References: <1305704452.1834.12.camel@deskari> <87k4douvsd.fsf@ti.com>
	<1305718422.1834.23.camel@deskari> <877h9ot7c3.fsf@ti.com>
	<1305729690.30372.7.camel@deskari> <1306252069.2194.28.camel@deskari>
	<87lixv1x3s.fsf@ti.com> <1306312262.2062.16.camel@deskari>
	<87ipsyvdc6.fsf@ti.com> <1306349159.2062.32.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:33699 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754379Ab1EYUaj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 May 2011 16:30:39 -0400
Received: by mail-pz0-f45.google.com with SMTP id 30so13542pzk.18
        for <linux-omap@vger.kernel.org>; Wed, 25 May 2011 13:30:38 -0700 (PDT)
In-Reply-To: <1306349159.2062.32.camel@deskari> (Tomi Valkeinen's message of
	"Wed, 25 May 2011 21:45:59 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org

Tomi Valkeinen <tomi.valkeinen@ti.com> writes:

> On Wed, 2011-05-25 at 11:34 -0700, Kevin Hilman wrote:
>> Tomi Valkeinen <tomi.valkeinen@ti.com> writes:
>> 
>> [...]
>> 
>> >> 
>> >> You're right, the code is just wrong here and would lead to strange
>> >> return value checking in the callers to be correct.
>> >> 
>> >> I think the best fix for this problem is to use a signed return value
>> >> which can wrap as expected, and then use return negative error codes
>> >> (e.g. -ENODEV).
>> >> 
>> >> Care to send a patch?  or do you have any other suggestions for a fix?
>> >
>> > Here's a patch. 
>> 
>> Thanks!
>
> <snip>
>
>> > @@ -311,22 +311,26 @@ void omap_pm_disable_off_mode(void)
>> >  
>> >  #ifdef CONFIG_ARCH_OMAP2PLUS
>> >  
>> > -u32 omap_pm_get_dev_context_loss_count(struct device *dev)
>> > +int omap_pm_get_dev_context_loss_count(struct device *dev)
>> >  {
>> >  	struct platform_device *pdev = to_platform_device(dev);
>> > -	u32 count;
>> > +	int count;
>> >  
>> >  	if (WARN_ON(!dev))
>> > -		return 0;
>> > +		return -ENODEV;
>> >  
>> >  	if (dev->parent == &omap_device_parent) {
>> >  		count = omap_device_get_context_loss_count(pdev);
>> >  	} else {
>> >  		WARN_ONCE(off_mode_enabled, "omap_pm: using dummy context loss counter; device %s should be converted to omap_device",
>> >  			  dev_name(dev));
>> > -		if (off_mode_enabled)
>> > -			dummy_context_loss_counter++;
>> > +
>> >  		count = dummy_context_loss_counter;
>> > +
>> > +		if (off_mode_enabled) {
>> > +			count = (count + 1) & 0x7fffffff;
>> > +			dummy_context_loss_counter = count;
>> > +		}
>> 
>> Again, I don't think this masking is needed.   count is already an
>> 'int', so when it gets bigger than INT_MAX, it will wrap.
>
> When count is INT_MAX and one is added to it, it'll wrap to INT_MIN,
> i.e. maximum negative value, which would be an error value. So by
> masking out the highest bit we'll get nonnegative count range from 0 to
> INT_MAX.
>
> Perhaps a comment would be justified here =).

Indeed, and using INT_MAX instead of the hard-coded constants would help
readability also.

Thanks,

Kevin
