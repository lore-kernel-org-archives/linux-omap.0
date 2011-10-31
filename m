From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: RE: [RFC] Change ECC algorithm from userspace
Date: Mon, 31 Oct 2011 09:04:06 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1110310856560.30940@lnxricardw.se.axis.com>
References: <70E876B0EA86DD4BAF101844BC814DFE0BF244FAD1@Cloud.RL.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <70E876B0EA86DD4BAF101844BC814DFE0BF244FAD1@Cloud.RL.local>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
	<mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
	<mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: linux-mtd-bounces@lists.infradead.org
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Jon Povey <Jon.Povey@racelogic.co.uk>
Cc: Enric Balletbo i Serra <eballetbo@iseebcn.com>, Javier Martinez Canillas <martinez.javier@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org


On Fri, 28 Oct 2011, Jon Povey wrote:

> linux-mtd-bounces@lists.infradead.org wrote:
>> I want to be able to use 1-bit ECC for the first partition where I
>> save the loader binary and has to be accessed by the ROM boot but use
>> a 4-bit ECC for my rootfs partition.
>>
>> Does anyone have this same issue?
>
> DM355 and DM365 has similar issues as the RBL expects a different OOB/ECC
> layout to Linux.

Slightly off-topic, but in the 355/365 (etc) case it's possible to modify =

the Linux driver so it uses the RBL ECC layout. For us, it seemed the =

easiest thing to do, as having different ECC layouts in different parts
of the flash proved to be a pain. If you need different ECC algorithms in
different parts of the flash this wouldn't work of course.

/Ricard
-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
