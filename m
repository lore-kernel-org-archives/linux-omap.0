From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [RFC][PATCH 1/1] ARM: Add initial hibernation support
Date: Thu, 15 Jul 2010 09:00:28 +0300 (EEST)
Message-ID: <20100715.090028.189718162.Hiroshi.DOYU@nokia.com>
References: <201007150648.50521.marek.vasut@gmail.com>
	<20100715.083931.226798141.Hiroshi.DOYU@nokia.com>
	<201007150756.11817.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <201007150756.11817.marek.vasut@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: marek.vasut@gmail.com
Cc: khilman@deeprootsystems.com, Yoshiya.Hirase@nokia.com, teerth@ti.com, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: ext Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [RFC][PATCH 1/1] ARM: Add initial hibernation support
Date: Thu, 15 Jul 2010 07:56:11 +0200

> Dne =C8t 15. =E8ervence 2010 07:39:31 Hiroshi DOYU napsal(a):
>> From: ext Marek Vasut <marek.vasut@gmail.com>
>> Subject: Re: [RFC][PATCH 1/1] ARM: Add initial hibernation support
>> Date: Thu, 15 Jul 2010 06:48:50 +0200
>> =

>> > Dne St 30. =E8ervna 2010 16:28:01 Hiroshi DOYU napsal(a):
>> >> From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
>> >> =

>> >> Hibernation (a.k.a: Suspend-To-Disk) support for ARM
>> >> =

>> >> Based on the original work from Romit and Raghu at TI. The original
>> >> patch(*1) was sent to LOML by Teerth Reddy <teerth@ti.com>
>> >> =

>> >> *1: https://patchwork.kernel.org/patch/96442/
>> >> =

>> >> Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
>> > =

>> > Hey, can this also run on pre-v7 arms ? Or is there something I missed
>> > that'd make that impossible?
>> =

>> What I verified is with OMAP3(Cortex A8) based board.
>> =

>> cp15 part has to be modified, but it might work without this part itself=
, I
>> guess.
> =

> I see ... do I need any special support on the bootloader or userland sid=
e ?

No, I don't think so. The resuming boot could set up most of states basical=
ly.
