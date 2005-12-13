From: "Menon, Nishanth" <x0nishan@ti.com>
Subject: RE: Problem with ALSA in 2.6.14-omap2 on OSK
Date: Tue, 13 Dec 2005 10:18:13 -0600
Message-ID: <520AB2AD990DC04082102F77CA17263802021F4C@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Dirk Behme <dirk.behme@de.bosch.com>, Daniel Petrini <d.pensator@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> Some notes to my environment. I'm using ~5MB mp3 playing over NFS with
> madplay in ramdisk. Yesterday, I had an additional idea, but no time
to
> test it yet: Do you have PREEMPT (CONFIG_PREEMPT=3Dy) enabled? May be
this
> is the difference?
One suggestion, can u measure the time b/w subsequent writes?
Get_time_of_day or something of that sort can help. The average write
time should be within sampling rate. If not, it might point at latency
issues spend in user context.. since it is only 5 Meg, can u try a
ramdisk for the test - can isolate any issues due to network latencies..
just guessing here..
Regards,
Nishanth Menon
