From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Beep sound in the end of audio file
Date: Wed, 6 May 2009 10:01:25 -0400
Message-ID: <9e4733910905060701r33b7f3eaxf8d9da07f4bfd101@mail.gmail.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB0305559FCC@dbde02.ent.ti.com>
	<200905060833.10998.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <200905060833.10998.peter.ujfalusi@nokia.com>
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
Cc: "ext Aggarwal, Anuj" <anuj.aggarwal@ti.com>, alsa-devel@alsa-project.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Wed, May 6, 2009 at 1:33 AM, Peter Ujfalusi <peter.ujfalusi@nokia.com> w=
rote:
> Hello,
>
> On Tuesday 05 May 2009 20:03:57 ext Aggarwal, Anuj wrote:
>> Hi,
>>
>> After playing out any audio file on OMAP3 EVM, having TWL4030 codec,
>> I am hearing a beep sound. I have also tried implementing a mute function
>> in which I disabled all the inputs/outputs but still that didn't help.
>>
>> Any idea how this can be avoided?
>
> I have not heard from this kind of problem so far, which does not mean, t=
hat
> it does not exist ;)
> Can you describe the beep sound?
>
> After a quick look I can not pin point the soc board file used with the
> omap3evm board. Is it in the tree?
>
> Does the beep happens in these cases also (after stopping it with Ctrl+C):
> aplay -f dat /dev/zero
> aplay -f dat /dev/urandom


I'm having this problem on PowerPC....

Audio is played via multiple period buffers
Am interrupt is generated on the end of each period

The problem occurs at the end of the stream.
The period containing the end of stream plays and generates an interrupt.
ALSA then calls back with trigger(STOP)

But I can't shut off the DMA fast enough on these slower CPUs (not
3Ghz) to prevent the next period from starting to play. This next
period contains data from earlier in the stream. When a small amount
of it plays it sounds like a short tone beep.

The beep is only obvious if the last period being played mostly
contains silence. In that case the silence will play, then you will be
able to hear the burst of noise separated from the rest of the stream.

What I need to know is the address of the last valid sample in the
stream. If I knew that I could just program the DMA hardware to stop
after it played. I've been staring at ALSA core for a couple of days
trying to figure out how to get the address for the end of the stream.




>
>
> CC-ing alsa-devel...
>
>>
>> Thanks and Regards,
>> Anuj Aggarwal
>>
>> Platform Support Products
>> Texas Instruments Incorporated
>
>
> --
> P=E9ter
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>



-- =

Jon Smirl
jonsmirl@gmail.com
