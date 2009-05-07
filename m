From: Arun KS <getarunks@gmail.com>
Subject: Re: Beep sound in the end of audio file
Date: Thu, 7 May 2009 18:18:20 +0530
Message-ID: <dfeb90390905070548i6c581ce9g3bd10e0a65636aa9@mail.gmail.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB0305559FCC@dbde02.ent.ti.com>
	<200905071408.14629.peter.ujfalusi@nokia.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB030555A662@dbde02.ent.ti.com>
	<200905071424.45431.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <200905071424.45431.peter.ujfalusi@nokia.com>
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
Cc: "ext Aggarwal, Anuj" <anuj.aggarwal@ti.com>, "todd.fischer@ridgerun.com" <todd.fischer@ridgerun.com>, alsa-devel@alsa-project.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Thu, May 7, 2009 at 4:54 PM, Peter Ujfalusi <peter.ujfalusi@nokia.com> w=
rote:
> On Thursday 07 May 2009 14:16:12 ext Aggarwal, Anuj wrote:
>> > [Anuj]: What kernel are you using where you have the beep?
>>
>> [Aggarwal, Anuj] 2.6.29-rc3
>
> That version still has the old power up/down code. Since than there were =
23
> patches for the twl4030 codec.
> The Headset enable/disable mantra could be still wrong in the latest
> version...

But i tried with latest linux-omap tree(2.6.30-rc4) copying twl4030.*
files from latest linux sound tree.
I can still hear the tuck noise of DAPM on omap3evm board.

Arun
>
> --
> P=E9ter
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
