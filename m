From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: Beep sound in the end of audio file
Date: Wed, 6 May 2009 08:33:10 +0300
Message-ID: <200905060833.10998.peter.ujfalusi@nokia.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB0305559FCC@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0305559FCC@dbde02.ent.ti.com>
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
To: "ext Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Cc: alsa-devel@alsa-project.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hello,

On Tuesday 05 May 2009 20:03:57 ext Aggarwal, Anuj wrote:
> Hi,
>
> After playing out any audio file on OMAP3 EVM, having TWL4030 codec,
> I am hearing a beep sound. I have also tried implementing a mute function
> in which I disabled all the inputs/outputs but still that didn't help.
>
> Any idea how this can be avoided?

I have not heard from this kind of problem so far, which does not mean, tha=
t =

it does not exist ;)
Can you describe the beep sound?

After a quick look I can not pin point the soc board file used with the =

omap3evm board. Is it in the tree?

Does the beep happens in these cases also (after stopping it with Ctrl+C):
aplay -f dat /dev/zero
aplay -f dat /dev/urandom


CC-ing alsa-devel...

>
> Thanks and Regards,
> Anuj Aggarwal
>
> Platform Support Products
> Texas Instruments Incorporated


-- =

P=E9ter
