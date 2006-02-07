From: Anderson Lizardo <anderson.lizardo@gmail.com>
Subject: Re: omap alsa tsc2101 driver
Date: Tue, 7 Feb 2006 12:19:50 -0400
Message-ID: <5b5833aa0602070819s4bded6d0i8be83e889add56b3@mail.gmail.com>
References: <43E66CF6.8040600@cc.jyu.fi>
	<9268368b0602061113n30e8c49bx756de24a1eaf93c6@mail.gmail.com>
	<43E7AEC3.3020901@cc.jyu.fi>
	<9268368b0602061401m4522d31v258f0f67f19509ef@mail.gmail.com>
	<43E8960E.6090005@cc.jyu.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <43E8960E.6090005@cc.jyu.fi>
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
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On 2/7/06, lamikr <lamikr@cc.jyu.fi> wrote:
> root@h6300:~# aplay 01_the_grudge.mp3
> Playing raw data '01_the_grudge.mp3' : Unsigned 8 bit, Rate 8000 Hz, Mono

AFAIK, aplay is not able to play MP3 files directly. try to convert
the file to WAV or use madplay.

Regards,
--
Anderson Lizardo
Embedded Linux Lab - 10LE
Nokia Institute of Technology - INdT
Manaus - Brazil
