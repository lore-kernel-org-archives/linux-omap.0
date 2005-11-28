From: Louis Jung <lhsj81@gmail.com>
Subject: Re: DSP core access
Date: Mon, 28 Nov 2005 18:41:35 -0500
Message-ID: <cb6819fd0511281541m7ea4161u9b8a8c984b52bfd7@mail.gmail.com>
References: <C51F43ABFC95844490F0529B60753BF402A3A8B8@dlee02.ent.ti.com>
	<20051123161308.96421.qmail@web34315.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20051123161308.96421.qmail@web34315.mail.mud.yahoo.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: comunerito <comunerito@yahoo.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Thanks heaps for your reply,

However, I was wondering whether this linux_dsp_tools are comaptible with
OMAP5910. The user guide states that it's a DSP development for TI OMAP5912=
.
Thanks again

On 11/23/05, comunerito <comunerito@yahoo.com> wrote:
>
>   See also:
>
>   https://www-a.ti.com/downloads/sds_support/LinuxDspTools/index.html
>
>   (you will have to register to download). There is a TI Reference
> Frameworks (RF6) base application that streams data from the codec to the
> DSP then to the ARM, then back to the DSP, then back to the codec. The
> DSP-side code implements an FIR filter and volume control but can be
> modified. The application uses TI's DSP/BIOS Link and Real-Time Analysis
> (RTA) for debugging.
>
>   CD
>
>
> "Hunter, Jon" <jon-hunter@ti.com> wrote:
>   Hi Louis
>
> >
> > Hi all,
> >
> > I am currently trying to obtain a real time data using DSP core on the
>
> > omap platform via the I2C peripheral. I was hoping to achieve this by
>
> > controlling the DSP via linux kernel that's running on the Arm core.
> > There is a DSP gateway through which I think i should be able to
> > control. Does anyone know the specific ways of doing this?
> >
>
> You could also use the dsp/bios link software for controlling the DSP
> and streaming data between the ARM and DSP. See the following link.
> There are some simple example applications provided to get you started.
> http://focus.ti.com/dsp/docs/dspsupportatn.tsp?sectionId=3D3&tabId=3D477&=
fam
> ilyId=3D44&toolTypeId=3D5
>
> In order to use the i2c peripheral from the DSP side you first need to
> configure the static switch in the device because this is a
> shared-peripheral and defaults as an ARM peripheral. For more details
> please refer to section 2.5 of the following document:
> http://focus.ti.com/docs/apps/catalog/resources/appnoteabstract.jhtml?ab
> stractName=3Dspru758a
>
> Regards,
> Jon
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>
>
>
>
> ---------------------------------
> Yahoo! FareChase - Search multiple travel sites in one click.
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>
