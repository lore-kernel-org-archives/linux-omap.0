From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] lis3lv02d: Add STMicroelectronics lis33ldlh digital
Date: Tue, 17 Jan 2012 15:47:02 -0800
Message-ID: <20120117154702.d009df12.akpm@linux-foundation.org>
References: <1324617892-14576-1-git-send-email-anilkumar@ti.com>
	<331ABD5ECB02734CA317220B2BBEABC13177CDA4@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13177CDA4@DBDE01.ent.ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "AnilKumar, Chimata" <anilkumar@ti.com>
Cc: "arnd@arndb.de" <arnd@arndb.de>, "greg@kroah.com" <greg@kroah.com>, "eric.piel@tremplin-utc.net" <eric.piel@tremplin-utc.net>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Nori, Sekhar" <nsekhar@ti.com>
List-Id: linux-omap@vger.kernel.org

On Tue, 17 Jan 2012 07:32:47 +0000
"AnilKumar, Chimata" <anilkumar@ti.com> wrote:

> Hi All,
> 
> Recalling the patch, provide the comments if there are any if not please include
> this patch to v3.3 kernel.

The patch is all mangled by someone's email client.  Wordwrapping, mime
crap which my MUA can't decrypt, etc.

> -----Original Message-----
> From: AnilKumar, Chimata 
> Sent: Friday, December 23, 2011 10:55 AM
> To: arnd@arndb.de; greg@kroah.com; eric.piel@tremplin-utc.net; akpm@linux-foundation.org; broonie@opensource.wolfsonmicro.com; linux-kernel@vger.kernel.org
> Cc: linux-omap@vger.kernel.org; Nori, Sekhar; AnilKumar, Chimata

A pet peeve which I haven't told anyone about.  If you've cc'ed someone
on a patch then I want to cc them on the patch too.  That means I have
to add their Cc: lines to the changelog.  But such Cc: lines include
their real names.  By omitting their real names in the above fashion,
you cause extra hassle for me.  Ideally, you should add their Cc: to
the changelog as well as to the mail headers, to give thsoe people the
best chance of seeing what is happening with the patch.

>
> ..
>
> +static ssize_t lis3lv02d_range_show(struct device *dev,
> +			       struct device_attribute *attr, char *buf)
> +{
> +	lis3lv02d_sysfs_poweron(&lis3_dev);
> +	return sprintf(buf, "%d\n", lis3_dev.g_range);
> +}

Are these interfaces documented anywhere?  If so, please update that
documentation.  If not, why not ;)

> @@ -809,15 +881,33 @@ static ssize_t lis3lv02d_rate_set(struct device *dev,
>  	return count;
>  }
>  
> +static ssize_t lis3lv02d_range_set(struct device *dev,
> +				struct device_attribute *attr, const char *buf,
> +				size_t count)
> +{
> +	unsigned long range;
> +
> +	if (strict_strtoul(buf, 0, &range))

checkpatch would have told you that strict_strtoul() is deprecated. 
Please always use checkpatch.
