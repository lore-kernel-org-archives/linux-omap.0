From: "James Selvam" <james.iisc@gmail.com>
Subject: Re: [PATCH 0/3] aic23 sound driver fixes
Date: Tue, 23 May 2006 10:05:10 +0530
Message-ID: <fd1e34b0605222135x650aaac9t31437eac3b9fdb7a@mail.gmail.com>
References: <4457C35D.4020700@cc.jyu.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <4457C35D.4020700@cc.jyu.fi>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: lamikr@cc.jyu.fi
Cc: OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi Mika/All,

Im happy to inform you that the patches you sent have been tested and they
are found to be working fine on my Innovator 1510. There should be no
problem with it going into the git.

I was bogged down by a hardware snag on my Innovator kit which delayed the
verification. But I see its fine now. :-) .

Thanx for the help.

Regards,
James.


On 5/3/06, lamikr <lamikr@cc.jyu.fi> wrote:
>
> Following patch set should fix the broken method references to from Alsa
> and OSS drivers to tlv320aic23 i2c drivers that has been reported.
> In addition the 3:rd patch contains the platform driver code that the
> innovator requires if it wants to use alsa driver.
>
> I do not own myself the innovator or aic23 drivers so it would be nice
> if someone else could test these.
>
> Mika
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>
