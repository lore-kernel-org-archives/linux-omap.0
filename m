From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: RE: camera mode in SDP
Date: Thu, 14 Jun 2007 23:42:56 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C470123C6AE@dlee13.ent.ti.com>
References: <8bf247760706141356h275c6145sb03d9c3d60136e42@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <8bf247760706141356h275c6145sb03d9c3d60136e42@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Ram <vshrirama@gmail.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Sriram,

> Is ex3691 is connected in parallel mode or CCP mode on SDP?.
2430 SDP has Parallel sensor.=20

Where do you see the ambiguity? Did you mean this line?
> * which must be configured are:  NOBT_SYNCHRO, BT_CORRECT, =
PAR_ORDERCAM,
> * PAR_CLK_POL, NOBT_HS_POL, NOBT_VS_POL, PAR_MODE, and CCP_MODE.=20

There are two separate bits CCP_MODE (to operate in CCP or Parallel mode =
and PAR_MODE (No of Bits) in CC CRTL register that must be configured =
accordingly.

>According to the code,  The function sets omap24xxcam_cc_enable
>sets it to the parallel mode.the comment to this function says a =
totally
>different thing (CCP mode).

The Bit in CC CTRL to configure/select CCP or Parallel mode is called =
CCP_MODE. May be that is confusing you.

>Most of us would prefer a generic way of choosing the type of
>interface CCP/serially
>so that we need to add sensor drivers if the sensor changes.

Feel free to participate in Sakari's camera discussions on V4L list, he =
is working on creating a generic interface for camera sensor. This might =
interest you.

Regards,
Khasim
