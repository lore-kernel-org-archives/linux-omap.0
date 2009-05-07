From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: Beep sound in the end of audio file
Date: Thu, 7 May 2009 17:15:22 +0300
Message-ID: <20090507171522.afed1a86.jhnikula@gmail.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB0305559FCC@dbde02.ent.ti.com>
	<1241619589.8928.2038.camel@sax-lx.fischerfamily.org>
	<200905070848.25904.peter.ujfalusi@nokia.com>
	<200905071408.14629.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <200905071408.14629.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>, "todd.fischer@ridgerun.com" <todd.fischer@ridgerun.com>, alsa-devel@alsa-project.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Thu, 7 May 2009 14:08:14 +0300
Peter Ujfalusi <peter.ujfalusi@nokia.com> wrote:

> I need to revisit this...
> After more testing and debugging, it seams that I can not confirm the 
> existence of the "tuck" (with the latest twl4030  codec code).
> As soon as I receive my Beagle board I will test it again (can anyone
> test this with latest ASoC code on Beagle?)...
> 
I can hear somewhat audible (stetson guessed -20 db
from /dev/urandom level) power-up/-down pop with "aplay -f
dat /dev/zero" but no any other beeps or noises.

I cannot hear any difference in pop level am I using head of linux-omap
or when merging sound-2.6/asoc on top of it.

Of cource this pop noise can be codec output & load dependent and also
possible on-board amplifier with proper power sequencing can mask the
noise. For reference, output jack of the Beagle is connected directly
into HSOL and HSOR pins.


-- 
Jarkko
