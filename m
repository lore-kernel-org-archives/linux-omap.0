From: Arun KS <getarunks@gmail.com>
Subject: Re: Beep sound in the end of audio file
Date: Thu, 7 May 2009 15:05:08 +0530
Message-ID: <dfeb90390905070235i47f9aed4lbd2298ba07a5b989@mail.gmail.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB0305559FCC@dbde02.ent.ti.com>
	<200905060833.10998.peter.ujfalusi@nokia.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB030555A348@dbde02.ent.ti.com>
	<20090506140719.GF6573@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20090506140719.GF6573@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: linux-omap@vger.kernel.org

On Wed, May 6, 2009 at 7:37 PM, Mark Brown <broonie@sirena.org.uk> wrote:
> On Wed, May 06, 2009 at 07:30:03PM +0530, Aggarwal, Anuj wrote:
>
>> > After a quick look I can not pin point the soc board file used with the
>> > omap3evm board. Is it in the tree?
>
>> [Aggarwal, Anuj] No, it is not. Reason being we already have beagle &
>> sdp3430 there, which are both similar to omap3evm, which I pushed.
>> So mine got rejected. We had some discussions on how to handle this
>> scenario but nothing got finalized.
>
> Not from the ALSA side it didn't...

Mark,

Since we are not going with the generic driver, are you going to push
this patch:

http://www.mail-archive.com/linux-omap@vger.kernel.org/msg07166.html

> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
