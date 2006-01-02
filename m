From: RAVI SHANGAR <ravishangar@gmail.com>
Subject: Qtopia in OMAP1510
Date: Mon, 2 Jan 2006 18:23:45 +0530
Message-ID: <ade4abe50601020453q317ba82je00bb09e66af815b@mail.gmail.com>
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

We got error while configuring Qtopia 2.2 for OMAP1510 (static) as below:

./configure -xplatform linux-arm-g++  -I /home/thiru/innqt/jpeglib/include
-L /home/thiru/innqt/jpeglib/lib -I /home/thiru/innqt/uuidlibs -L
/home/thiru/innqt/uuidlibs -no-quicklaunch -no-qtopiadesktop -singleexec
The following configuration values have been guessed or autodetected:
    -arch arm
    -displaysize 240-320
    -edition pda
    -fontfamilies helvetica fixed micro smallsmooth smoothtimes
    -fontsizes all
    -fontstyles 50 50i 75 75i
    -languages en_US
    -platform linux-g++

WARNING: defaultbuttons-arm.conf does not exist.
Symlinking header files to include directory
Creating qmake..............................................
Creating
pngscale...................................................................=
.make:
*** [../../bin/pngscale] Error 1
Failed to make pngscale

Could u pl give any solution for this error?
