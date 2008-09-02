From: "Steve Sakoman" <sakoman@gmail.com>
Subject: Re: [PATCH 3/4] SOUND: SOC: OMAP: Add support for
	Gumstix Overo
Date: Tue, 2 Sep 2008 06:19:10 -0700
Message-ID: <5e088bd90809020619k2a852e78ra33ae5ee4415da4d@mail.gmail.com>
References: <1220306279-27977-1-git-send-email-sakoman@gmail.com>
	<1220306279-27977-2-git-send-email-sakoman@gmail.com>
	<1220306279-27977-3-git-send-email-sakoman@gmail.com>
	<1220306279-27977-4-git-send-email-sakoman@gmail.com>
	<20080902112936.GC25176@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20080902112936.GC25176@sirena.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: sakoman@gmail.com, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, Steve Sakoman <steve@sakoman.com>
List-Id: linux-omap@vger.kernel.org

On Tue, Sep 2, 2008 at 4:29 AM, Mark Brown <broonie@sirena.org.uk> wrote:

>>  # OMAP Machine Support
>>  snd-soc-n810-objs := n810.o
>> +snd-soc-omap3evm-objs := omap3evm.o
>> +snd-soc-omap3beagle-objs := omap3beagle.o
>> +snd-soc-overo-objs := overo.o
>
> Looks like some extra stuff crept in here...
>

Heh :-)  Right you are!

I've been testing the driver on Beagle and OMAP3EVM too.  I'll fix and resubmit.

Steve
