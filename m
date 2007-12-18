From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: ethernet performace on 3430SDP ES1.0
Date: Tue, 18 Dec 2007 10:00:29 -0600
Message-ID: <3B6D69C3A9EBCA4BA5DA60D91302742902CC1C92@dlee13.ent.ti.com>
References: <D0D7E940253EF8428A27241F8E3CABA3A88E0F@zeus.Combra.se>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <D0D7E940253EF8428A27241F8E3CABA3A88E0F@zeus.Combra.se>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Carl Benson <Carl.Benson@combra.se>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

If you change your boot args to use rsize=3D1024,rsize=3D1024,tcp this
effect will go away.

The wake up for the ethernet interrupt is not enabled in that load.  As
such its only being polled at the dynamic tick rate.

If your using default NFS parameters then you end up in a case where you
need to re-transmit large UDP/NFS blocks.  If you fail in the
re-transmit your in trouble.

By breaking them up a bit smaller the effect is removed.  You still
loose a one every now and then by the re-transmit is effective.

Knocking off power will make things work for sure but you will be
running at as much as 100x the power.  It will also not make you so
power sensitive when you construct your next layers.  Better to take the
effort in parallel when constructing functionality as opposed to come
back to it when you think your done and have to re-write when its not
fresh.

In some future build I think more of the wake up bits will be fully
sorted out.  Right now the standard ARM mapping of IO regions has some
issues in my opinion with relation to posting and synchronization.  This
makes spurious interrupts a bit more likely.

Regards,
Richard W.

=20
> =20
> If I try to ping the device from my NFS server, I get really=20
> sporadic delays between the replies, however all requests are echoed.
>=20
> PING 192.168.0.39 (192.168.0.39) 56(84) bytes of data.
> 64 bytes from 192.168.0.39: icmp_seq=3D1 ttl=3D64 time=3D340 ms
> 64 bytes from 192.168.0.39: icmp_seq=3D2 ttl=3D64 time=3D138 ms
> 64 bytes from 192.168.0.39: icmp_seq=3D3 ttl=3D64 time=3D245 ms
> 64 bytes from 192.168.0.39: icmp_seq=3D4 ttl=3D64 time=3D26.0 ms
> 64 bytes from 192.168.0.39: icmp_seq=3D5 ttl=3D64 time=3D477 ms
> 64 bytes from 192.168.0.39: icmp_seq=3D6 ttl=3D64 time=3D278 ms
> 64 bytes from 192.168.0.39: icmp_seq=3D7 ttl=3D64 time=3D78.1 ms
> 64 bytes from 192.168.0.39: icmp_seq=3D8 ttl=3D64 time=3D858 ms
> 64 bytes from 192.168.0.39: icmp_seq=3D9 ttl=3D64 time=3D638 ms
> 64 bytes from 192.168.0.39: icmp_seq=3D10 ttl=3D64 time=3D438 ms
> 64 bytes from 192.168.0.39: icmp_seq=3D11 ttl=3D64 time=3D238 ms
> 64 bytes from 192.168.0.39: icmp_seq=3D12 ttl=3D64 time=3D38.4 ms
> 64 bytes from 192.168.0.39: icmp_seq=3D13 ttl=3D64 time=3D817 ms
> 64 bytes from 192.168.0.39: icmp_seq=3D14 ttl=3D64 time=3D598 ms
> 64 bytes from 192.168.0.39: icmp_seq=3D15 ttl=3D64 time=3D398 ms
> 64 bytes from 192.168.0.39: icmp_seq=3D16 ttl=3D64 time=3D198 ms
> 64 bytes from 192.168.0.39: icmp_seq=3D17 ttl=3D64 time=3D2.22 ms
> 64 bytes from 192.168.0.39: icmp_seq=3D18 ttl=3D64 time=3D116 ms
> 64 bytes from 192.168.0.39: icmp_seq=3D19 ttl=3D64 time=3D567 ms
> 64 bytes from 192.168.0.39: icmp_seq=3D20 ttl=3D64 time=3D367 ms
