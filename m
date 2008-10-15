From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: Re: [PATCH 3/3] Hook into powerdomain code
Date: Wed, 15 Oct 2008 17:32:03 +0300
Message-ID: <20081015143203.GD4660@codecarver.research.nokia.com>
References: <1223995198-19985-1-git-send-email-peter.de-schrijver@nokia.com> <1223995198-19985-2-git-send-email-peter.de-schrijver@nokia.com> <1223995198-19985-3-git-send-email-peter.de-schrijver@nokia.com> <1223995198-19985-4-git-send-email-peter.de-schrijver@nokia.com> <alpine.DEB.2.00.0810141353580.8581@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:26766 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752306AbYJOOch (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Oct 2008 10:32:37 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.0810141353580.8581@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Paul Walmsley <paul@booyaka.com>
Cc: linux-omap@vger.kernel.org

On Tue, Oct 14, 2008 at 01:55:07PM -0600, ext Paul Walmsley wrote:
> On Tue, 14 Oct 2008, Peter 'p2' De Schrijver wrote:
> 
> > @@ -179,9 +183,12 @@ void pwrdm_init(struct powerdomain **pwrdm_list)
> >  {
> >  	struct powerdomain **p = NULL;
> >  
> > -	if (pwrdm_list)
> > -		for (p = pwrdm_list; *p; p++)
> > +	if (pwrdm_list) {
> > +		for (p = pwrdm_list; *p; p++) {
> >  			pwrdm_register(*p);
> > +			_pwrdm_setup(*p);
> 
> perhaps I am going blind - could you point me at where _pwrdm_setup() is 
> defined?
> 

Hmm. This seems to be a change which should have been in the normal pm
counters patch. Somehow it didn't get there. I will send an updated
version of that patch.

Cheers,

Peter.

-- 
goa is a state of mind
