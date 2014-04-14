From: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 05/14] arm: common: edma: Select event queue 1 as
	default when booted with DT
Date: Mon, 14 Apr 2014 14:56:03 +0300
Message-ID: <534BCCD3.9060805@ti.com>
References: <1396357575-30585-1-git-send-email-peter.ujfalusi@ti.com>
	<1396357575-30585-6-git-send-email-peter.ujfalusi@ti.com>
	<5347A4FD.1030803@ti.com> <5347ACDE.7040407@ti.com>
	<5347AE49.5020109@ti.com> <5347B7F8.2000508@ti.com>
	<20140411094217.GA32284@intel.com> <5347D2CC.4030407@ti.com>
	<20140411113154.GB32284@intel.com> <5347DEDA.2060008@ti.com>
	<20140411124641.GC32284@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <20140411124641.GC32284-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, joelf-l0cyMroinI0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mporter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Vinod,

On 04/11/2014 03:46 PM, Vinod Koul wrote:
> I think the number shouldn't be viewed in absolute terms. If we decide th=
at (lets
> say) 0-7, then any controller should map 0 to lowest and 7 to highest.
> =

> For your case you can do this and then intermediate numbers would be medi=
um
> priority. Such a system might work well...
> =

> Also how would a client driver know which priority to use? Would it come =
from
> DT?

I think DT would be the best place.
Not sure if we should set the range for this either. What I was thinking is=
 to
add an optional new property to be set by the client nodes, using DMA:

mcasp0: mcasp@48038000 {
	compatible =3D "ti,am33xx-mcasp-audio";
	...
	dmas =3D	<&edma 8>,
		<&edma 9>;
	dma-names =3D "tx", "rx";
	dma-priorities =3D <2>, <2>;
};

We could agree that lower number means lower priority, higher is - well -
higher priority.
If the dma-priority is missing we should assume lowest priority (0).
The highest priority depends on the platform. For eDMA3 in AM335x it is thr=
ee
level. For designware controller you might have the range 0-8 as valid.

The question is how to get this information into use?
We can take the priority number in the core when the dma channel is request=
ed
and add field to "struct dma_chan" in order to store it and the DMA drivers
could have access to it.
In this way we only need to update the nodes which needs non default priori=
ty
for DMA.

What do you think?

-- =

P=E9ter
