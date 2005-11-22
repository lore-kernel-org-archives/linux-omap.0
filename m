From: Nathan Ladd <nathanladd@gmail.com>
Subject: Cannot build tokliBIOS.lib
Date: Mon, 21 Nov 2005 23:51:17 -0600
Message-ID: <edea273a0511212151j2681531bo7e8cdd33fd0d69da@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

I'm following the instructions in DSPGW33-tokliBIOS-gen11.pdf to build
tokliBIOS for the first time. However, it seems that tconf is not configure=
d
properly. However, I can follow the dsp bios user guide and build the sampl=
e
programs they have (which use tconf). The specific error I get is this:

~/bbi/ti/bios_5_03/tconf/tconf -Dconfig.importPath=3D~/bbi/ti/bios_5_03
tokliBIOScfg.tcf
js: "/home/nathan/bbi/ti/bios_5_03/tconf/include/utils.tci", line 739:
uncaught JavaScript exception: Error: Can't find Platform.tc[ip] file for '
ti.platforms.ti.platforms.generic'
make: *** [tokliBIOScfg.s55] Error 1

I've done some research, and it seems that the LoadPlatform function is wha=
t
is failing. The function is designed to search through some local search
path using utils.findPkgFile(), which in turn calls utils.findFile().

The comment section above utils.findFile() says that "If no path is
specified, findFile looks along the path
".;config.path;config.rootDir/include;config.importPath"

I suppose I need to somehow set these; shouldn't this be done automatically=
?
(I used the generic subpkg_install_linuxdsptools.exp script to install the
Linux DSP tools).

I forced utils.loadPlatform() to assign a hard path to the variable which
ends up storing the result of the search, but I get further errors
complaining about not finding other important files.

I've found that between all of the Linux DSP tools, many of them have
conflicting variable names and paths for the different components. Is there
something else I need to change from the default in order to coax tconf to
work properly? Again, I'm able to use tconf to build other example code in
the Linux DSP Tools distribution.

I've just spent a lot of time trying to work this out on my own with no
luck. I'd appreciate any help anyone could offer.

--Nathan
