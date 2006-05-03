From: "James Selvam" <james.iisc@gmail.com>
Subject: Re: [PATCH 0/3] aic23 sound driver fixes
Date: Wed, 3 May 2006 16:50:52 +0530
Message-ID: <fd1e34b0605030420g68f908f7y447d6a4ed2001fc0@mail.gmail.com>
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

I am working on OMAP1510 Innovator (kernel 2.6.16.13+omap1). I applied the
patches sent here, but the second hunk containing the change of function
calls to "aic23_write_value" were not defined so I changed them back to
"tlv320aic23_write_value". But the platform related patch was applied in
toto.

The kernel then recognised the AIC23 codec at bootup (which it was not doin=
g
before). Also the I2C has set the MCBSP clocks 1 and 3. But ALSA did throw
up an error:

Clock enabled to MCBSP1 & 3
tlv320aic23 powering up
tlv320aic23_init_power() done
TLV320AIC23 I2C version 1.8 (10-Feb-2006)

Advanced Linux Sound Architecture Driver Version 1.0.11rc2 (Wed Jan 04
08:57:20 2006 UTC).
Cannot set MCLK for AIC23 CODEC
audio support initialized
ALSA device list:
  #0: OMAP Innovator AIC23

Thereafter if we try to run an application it promts the same error "Cannot
set MCLK for AIC23 CODEC" and fails to recognise the device present.

Certain clarifications are required:
1) Where is the definition of the function "aic23_write_value" - specified
in the first two patches?
2) The MCLK not being set; the MCBSP clocks are set all right during the
bootup. Why then does it crib now?
3) Are the MCLK and the MCBSP clocks one and the same?

We have cross-compiled the ALSA utils (aplay, arec & speaker-test) as also
ALSA libraries separately & included the same in the file-system. Does ALSA
require any configuration before we can use the utils?

-James.

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
