From: Ming Lei <ming.lei@canonical.com>
Subject: Re: [PATCH] usb: ehci: fix update qtd->token in qh_append_tds
Date: Sun, 28 Aug 2011 11:35:03 +0800
Message-ID: <CACVXFVP_FbcUprZu5pxHqeTTy+eed3F_Lb8yrOg51n6WbwckKQ@mail.gmail.com>
References: <CACVXFVNrck4u3d7EaRwuwSVO9J-_0jDQ07U0PCw55FZUxsCszA@mail.gmail.com>
	<Pine.LNX.4.44L0.1108271607150.21403-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <Pine.LNX.4.44L0.1108271607150.21403-100000@netrider.rowland.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg KH <greg@kroah.com>, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Sun, Aug 28, 2011 at 4:11 AM, Alan Stern <stern@rowland.harvard.edu> wro=
te:
> On Sun, 28 Aug 2011, Ming Lei wrote:
>
>> Looks like there is still another similar problem in qh_link_async():
>> the last wmb
>> should be changed into mb, because HC will read 'head->hw->hw_next' from=
 qh
>> descriptor and this pointer in qh is read only for HC. But this problem =
can't be
>> observed on ARM, since wmb on ARM is same with mb.
>
> It doesn't matter what the HC does -- the wmb() instruction is executed
> by the CPU, not the HC. =A0The point of that instruction is to make sure
> that the
>
> =A0 =A0 =A0 =A0qh->hw->hw_next =3D head->hw->hw_next;
>
> line (and all the preceding lines as well) is ordered before the
>
> =A0 =A0 =A0 =A0head->hw->hw_next =3D dma;
> 3C
> line. =A0Since both of these lines are writes, not reads, it suffices to
> use wmb() rather than mb().

oops,  I added a wmb() after the line of 'head->hw->hw_next =3D dma;',
in my debug code, and not found that it is my local modification before
sending out last mail. (I described it as 'the last wmb' in fact), sorry fo=
r the
noise, please ignore it.

thanks,
--
Ming Lei
