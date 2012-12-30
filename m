From: Abdulrahman Hemaily <ahemaily@gmail.com>
Subject: Re: [PATCH 1/1] arm :omap :DMA: fix a bug on reserving the omap SDMA
 channels
Date: Sun, 30 Dec 2012 15:09:44 +0200
Message-ID: <CAJz1Lf2gDVo4n6fF=w1CdFCOWwWm4R5iheAS6EFnKocSJwW5Tg@mail.gmail.com>
References: <1356813800-4705-1-git-send-email-ahemaily@gmail.com>
 <50DFDE2A.3070800@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6389482626035098309=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <50DFDE2A.3070800@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux@arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============6389482626035098309==
Content-Type: multipart/alternative; boundary=14dae9340ca33cd51f04d2119cef

--14dae9340ca33cd51f04d2119cef
Content-Type: text/plain; charset=ISO-8859-1

sorry for the grammar mistakes.

Regards,,

On 30 December 2012 08:24, Santosh Shilimkar <santosh.shilimkar@ti.com>wrote:

> $subject
> s/arm:omap/ARM: OMAP:
>
>
> On Sunday 30 December 2012 02:13 AM, ahemaily@gmail.com wrote:
>
>> From: ahemaily <ahemaily@gmail.com>
>>
>> The variable  dma_lch_count  used for comparison
>>  (omap_dma_reserve_channels <= dma_lch_count)
>> before it initialized to the value from omap_dma_dev_attr : d->lch_count.
>>
> s/it/it is
>
>
>  I change the place of dma_lch_count initialization to be before the
>> comparison.
>>
>>  s/I change the place of dma_lch_count initialization to be before the
> comparison./ Initialize dma_lch_count before it is being used for
> comparison.
>
>
>  Signed-off-by: Abdelrahman Hemaily <ahemaily@gmail.com>
>> ---
>>
> Change looks good to my eyes o.w
>
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>
>

--14dae9340ca33cd51f04d2119cef
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">sorry for the grammar mistakes.<br><br>Regards,,<br><br><d=
iv class=3D"gmail_quote">On 30 December 2012 08:24, Santosh Shilimkar <span=
 dir=3D"ltr">&lt;<a href=3D"mailto:santosh.shilimkar@ti.com" target=3D"_bla=
nk">santosh.shilimkar@ti.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">$subject<br>
s/arm:omap/ARM: OMAP:<div class=3D"im"><br>
<br>
On Sunday 30 December 2012 02:13 AM, <a href=3D"mailto:ahemaily@gmail.com" =
target=3D"_blank">ahemaily@gmail.com</a> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
From: ahemaily &lt;<a href=3D"mailto:ahemaily@gmail.com" target=3D"_blank">=
ahemaily@gmail.com</a>&gt;<br>
<br>
The variable =A0dma_lch_count =A0used for comparison =A0(omap_dma_reserve_c=
hannels &lt;=3D dma_lch_count)<br>
before it initialized to the value from omap_dma_dev_attr : d-&gt;lch_count=
.<br>
</blockquote></div>
s/it/it is<div class=3D"im"><br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
I change the place of dma_lch_count initialization to be before the compari=
son.<br>
<br>
</blockquote></div>
s/I change the place of dma_lch_count initialization to be before the compa=
rison./ Initialize dma_lch_count before it is being used for comparison.<di=
v class=3D"im"><br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Signed-off-by: Abdelrahman Hemaily &lt;<a href=3D"mailto:ahemaily@gmail.com=
" target=3D"_blank">ahemaily@gmail.com</a>&gt;<br>
---<br>
</blockquote></div>
Change looks good to my eyes o.w<br>
<br>
Acked-by: Santosh Shilimkar &lt;<a href=3D"mailto:santosh.shilimkar@ti.com"=
 target=3D"_blank">santosh.shilimkar@ti.com</a>&gt;<br>
<br>
</blockquote></div><br></div>

--14dae9340ca33cd51f04d2119cef--


--===============6389482626035098309==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6389482626035098309==--
