From: <Toshihiro.Kobayashi@nokia.com>
Subject: RE: DSP Gateway application-reg
Date: Mon, 29 May 2006 20:47:27 +0900
Message-ID: <7AF192DA69C59243838FF62851F64F55025C3711@toebe101.NOE.Nokia.com>
References: <7e6cc7550605270036h2edb26cdvc3f128045dc72acb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <7e6cc7550605270036h2edb26cdvc3f128045dc72acb@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: nagubk82@gmail.com, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

From: ext naga rajan [mailto:nagubk82@gmail.com]=20
Sent: Saturday, May 27, 2006 4:37 PM

> Currently we are working on OSK5912 with DSP Gateway application
programs provided along with DSP Gateway version3.3. We verified the
wdsnd command program provided with the demo folder. We have some
queries to be clarified with that particular program (demo_console.c).=20

> Why we have to send a initial data from ARM to DSP?
> Note: On omitting this process, the program is not able to receive
data from DSP.

Because the DSP task consists of callbacks to the ARM's requests.

> Why we have to include a "busywait" in the DSP side in this word
transfer?
> Note:   On excluding "busywait", the data transfer is not proper.=20

That restriction comes from buffer size on ARM side.
For the Word Sending Tasks, DSP Gateway driver prepares 32-words
receiving buffer in ARM side in default.
If DSP sends data words faster than ARM reads, the receiving buffer will
overflow.
If you want a larger buffer, you can change the size of it through
/sys/devices/platform/dsp/dsptaskX/fifosz.

BR,
Toshihiro Kobayashi
