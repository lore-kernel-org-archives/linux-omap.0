From: lamikr <lamikr@cc.jyu.fi>
Subject: Re: Sound on OMAP1510 Innovator
Date: Thu, 09 Mar 2006 19:08:26 +0200
Message-ID: <4410610A.5060206@cc.jyu.fi>
References: <9343BE359FA4224CA72A94D8CC362C9C093648@edpc500.cedt.iisc.ernet.in>
Reply-To: lamikr@cc.jyu.fi
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <9343BE359FA4224CA72A94D8CC362C9C093648@edpc500.cedt.iisc.ernet.in>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Prakash Narayanan M <mnarayan@cedt.iisc.ernet.in>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi

Assuming that you are using /dev/dsp you are using OSS version from the
aic23 driver, am I correct?
Have you tested with the alsa version? In addition is normal music play
working ok for you?
("cat song.wav > /dev/dsp" with the oss driver and "aplayer song.wav"
with the alsa driver)

Mika

>I am trying to use the Sound device on Innovator OMAP1510.
>
>I am testing with a c code to acquire for sometime (3s) through the mic
>and replay it through the speaker.
>  
>
