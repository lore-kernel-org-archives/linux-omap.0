From: Jon Povey <Jon.Povey@racelogic.co.uk>
Subject: RE: [RFC] Change ECC algorithm from userspace
Date: Fri, 28 Oct 2011 11:33:43 +0100
Message-ID: <70E876B0EA86DD4BAF101844BC814DFE0BF244FAD1@Cloud.RL.local>
References: <CAAwP0s059H3BGhYbYLux2gR6ZNb+sFDue676OM2Evz5cA2q6DA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
Content-Class: urn:content-classes:message
In-Reply-To: <CAAwP0s059H3BGhYbYLux2gR6ZNb+sFDue676OM2Evz5cA2q6DA@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
	<mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
	<mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: linux-mtd-bounces@lists.infradead.org
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Javier Martinez Canillas <martinez.javier@gmail.com>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Enric Balletbo i Serra <eballetbo@iseebcn.com>
List-Id: linux-omap@vger.kernel.org

linux-mtd-bounces@lists.infradead.org wrote:
> I want to be able to use 1-bit ECC for the first partition where I
> save the loader binary and has to be accessed by the ROM boot but use
> a 4-bit ECC for my rootfs partition.
>
> Does anyone have this same issue?

DM355 and DM365 has similar issues as the RBL expects a different OOB/ECC
layout to Linux.

> What is the best approach to store data in a NAND device using
> different ECC techniques?

What I have done is write a utility that calculates ECC and writes to
the mtd device in RAW mode. So to rewrite the bootloader I take care of
the ECC and layout at application level without changing the kernel.

--
Jon Povey
jon.povey@racelogic.co.uk

Racelogic is a limited company registered in England. Registered number 2743719 .
Registered Office Unit 10, Swan Business Centre, Osier Way, Buckingham, Bucks, MK18 1TB .

The information contained in this electronic mail transmission is intended by Racelogic Ltd for the use of the named individual or entity to which it is directed and may contain information that is confidential or privileged. If you have received this electronic mail transmission in error, please delete it from your system without copying or forwarding it, and notify the sender of the error by reply email so that the sender's address records can be corrected. The views expressed by the sender of this communication do not necessarily represent those of Racelogic Ltd. Please note that Racelogic reserves the right to monitor e-mail communications passing through its network



______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
