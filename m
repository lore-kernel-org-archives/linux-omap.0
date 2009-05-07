From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: Beep sound in the end of audio file
Date: Thu, 7 May 2009 14:24:45 +0300
Message-ID: <200905071424.45431.peter.ujfalusi@nokia.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB0305559FCC@dbde02.ent.ti.com>
	<200905071408.14629.peter.ujfalusi@nokia.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB030555A662@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB030555A662@dbde02.ent.ti.com>
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
To: alsa-devel@alsa-project.org
Cc: "ext Aggarwal, Anuj" <anuj.aggarwal@ti.com>, "todd.fischer@ridgerun.com" <todd.fischer@ridgerun.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Thursday 07 May 2009 14:16:12 ext Aggarwal, Anuj wrote:
> > [Anuj]: What kernel are you using where you have the beep?
>
> [Aggarwal, Anuj] 2.6.29-rc3

That version still has the old power up/down code. Since than there were 23 =

patches for the twl4030 codec.
The Headset enable/disable mantra could be still wrong in the latest =

version...

-- =

P=E9ter
