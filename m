From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: MTD : Kernel oops when remounting ubifs as read/write
Date: Wed, 13 Mar 2013 13:20:38 +0200
Message-ID: <1363173638.11441.24.camel@sauron.fi.intel.com>
References: <5134CEF9.5070502@mimc.co.uk>
	 <1363087506.3348.62.camel@sauron.fi.intel.com>
	 <51405F3A.3090901@mimc.co.uk>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <51405F3A.3090901@mimc.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Jackson <mpfj-list@mimc.co.uk>
Cc: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, adrian.hunter@intel.com
List-Id: linux-omap@vger.kernel.org

On Wed, 2013-03-13 at 11:12 +0000, Mark Jackson wrote:
> > -	if (c->space_fixup) {
> > -		err = ubifs_fixup_free_space(c);
> > -		if (err)
> > -			goto out;
> > -	}
> > -
> >  	mutex_unlock(&c->umount_mutex);
> >  	return err;
> > 
> 
> Sorry ... this just locks up the unit.

Am I right that to reproduce it I need any image with the 'fixup' flag
set, then I should put it on the flash, mount it R/O and then remount
R/W. Right?

-- 
Best Regards,
Artem Bityutskiy
