From: "nishanth menon" <menon.nishanth@gmail.com>
Subject: Re: OMAP1710 H3: full duplex audio problem
Date: Thu, 14 Sep 2006 10:26:05 -0500
Message-ID: <782515bb0609140826u3e90f3dbqc6904a2cc90f1d2@mail.gmail.com>
References: <7b1b9c8b0609110333w565de1dckf47d5bfe982c24d3@mail.gmail.com>
	<7b1b9c8b0609132341k2f2547fbt7d379abe9e2cc344@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <7b1b9c8b0609132341k2f2547fbt7d379abe9e2cc344@mail.gmail.com>
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
To: Prashant <prashantkhoje@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Prashant,

On 9/14/06, Prashant <prashantkhoje@gmail.com> wrote:
> Simple "cat /dev/sound/dsp > /dev/sound/dsp" doesnt work either.
Soln: I think you should be moving to the latest git 2.6.17 kernel for
better support of 1710. 2.6.10 is obsolete and buggy. 2.6.17 tends to
be tested by lots of developers, and you have options of going for
ALSA or OSS there. The preferred is ALSA ofcourse. you can check the
archives for previous discussions on ALSA support.

Regards,
Nishanth Menon
