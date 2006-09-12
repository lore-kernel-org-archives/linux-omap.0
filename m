From: "Komal Shah" <komal_shah802003@yahoo.com>
Subject: [ANNOUNCE] dspfs tree
Date: Tue, 12 Sep 2006 14:53:43 +0530
Message-ID: <1158053023.1657.270711270@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
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

Paul Mundt has published the dspfs tree at the following location:
git://git.kernel.org/pub/scm/linux/kernel/git/lethal/dspfs-2.6.git

It is visible under http://www.kernel.org/git web interface. See that
is based from mainline tree _not_ linux-omap-2.6.git tree.

dspfs description based on the discussion with Paul and dspfs code.
----

dspfs - the DSP file system
=====

A simple resource management file system intended for use with 
asymmetric cores, and more specifically DSPs.

It is currently being modeled around the TMS320C55x DSP(found
in both OMAP1710 and OMAP2420) and OMAP2420 IVA1.0 blocks, but
it intended as simple resource management framework[2].

Need for dspfs?
=====

It is basically created more in the direction of a staging
ground for dspgatway[1] replacement, as current dspgateway having
following downsides:

o virtual bus and ioctls based tight coupling with task interface.
o Scalability - e.g. OMAP2420 IVA1 block with multiple co-processors.
o Familiarity of code with various developers.
o Acceptance of code to mainline tree
o Burden of maintenance

dspfs tries to address above problems while _not_ restricting it's 
implementation to TI OMAP-DSPs like processors.

FILES
=====

"/dsp" is the mount point for dspfs, but it can be mounted elsewhere too.

While mounting dspfs tries to create directories/files for all the processors
and it's children registered with it under the mountpoint.

Here is the example for OMAP2420(iva1 and c55x).

|-- c55x
|   |-- codecs
|      
`-- iva1
    |-- codecs
    `-- seq
        `-- codecs

1. iva1 can have its co-processors as child so dsp_register_child works here. 
   It can be like seq, vlcd, and imx.
2. For c55x, we will just need one entry, as there are no child processors as we know.
3. codecs directory gets created by default for each child or main parent directory
   under the mount-point.
4. codecs directory allows to create per-codec files under it.
   When you create a new codec file under codecs directory, a directory of the same
   name gets created at the same level of codecs directory with its default per-codec
   files. e.g.

|-- c55x
|   |-- codecs
|   |   `-- mp4
|   `-- mp4
|       |-- frmdata_0
|       `-- frmdata_1
`-- iva1
    |-- codecs
    `-- seq
        `-- codecs

5. When you remove codec-file under codecs directory, its parent directory with the same
   name also gets removed(but not codecs directory).

[1] http://dspgateway.sourceforge.net
[2] linux/Documentation/filesystem/spufs.txt

----

I will send the dummy C55x implementation patch, so that one can start playing with dspfs.

NOTE: Please CC to Paul Mundt, if you need his attention, as he is not subscribed to this list.

---Komal Shah
http://komalshah.blogspot.com

-- 
http://www.fastmail.fm - Does exactly what it says on the tin
