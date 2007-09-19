From: "=?ISO-8859-1?Q?Lu=EDs_Cargnini?=" <lvcargnini@gmail.com>
Subject: Re: [PATCH RFC] arch/arm/plat-omap/devices.c
Date: Tue, 18 Sep 2007 22:44:26 -0300
Message-ID: <ae36f8040709181844y4feeb156i87c24b4fe681443b@mail.gmail.com>
References: <ae36f8040709181333q2b8e3e6ena5d864b14178c582@mail.gmail.com>
	<20070918221143.GG2521@atomide.com>
Reply-To: lvcargnini@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <20070918221143.GG2521@atomide.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: OMAP <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Tony, I added the include files with ifdefs because the includes have the
almost the same defines but with different values fora each processor

On 9/18/07, Tony Lindgren <tony@atomide.com> wrote:
>
> Hi,
>
> * Lu=EDs Cargnini <lvcargnini@gmail.com> [070918 13:34]:
>
> We should just include all the headers we need, no need to ifdef them
> out.
>
> There are no real reasons why we could not compile in all the omap
> kernels into one binary now that gcc supports mixing in later assembly
> code. Adding ifdefs there will make compiling in support for various
> omaps harder. (We can already compile in 15xx and 16xx).
>
> Please also leave out changelog type comments, they will show up in
> the git repository. Also leave out any formatting changes, they make
> it harder to see what you're fixing. See the following under
> Documentation in your Linux tree:
>
> Documentation/SubmittingPatches
> Documentation/SubmittingDrivers
> Documentation/SubmitChecklist
>
> Regards,
>
> Tony
>



--=20
---------------------------------------------------------------------------=
---
Thanks && Regards
Msc. Bsc. Lu=EDs Vit=F3rio Cargnini
IEEE Member
Electrical Engineer Faculty @ PUCRS
Ipiranga Avenue, 6681 =96 Building 30
P.O. Box: 90619-900 =96 Porto Alegre/RS
Phone: +55 51 3320 3500  extension: 7696
---------------------------------------------------------------------------=
------
